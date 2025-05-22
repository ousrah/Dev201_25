<?php

namespace App\Exports;

use App\Models\User;
use App\Models\Exams\Pv;
use App\Models\Parameter;
use Illuminate\Http\Request;
use App\Models\School\School;
use App\Models\School\Section;
use App\Models\Learning\Material;
use App\Models\School\ScholarYear;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Events\AfterSheet;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use Maatwebsite\Excel\Events\BeforeSheet;
use PhpOffice\PhpSpreadsheet\Style\Color;
use PhpOffice\PhpSpreadsheet\Style\Style;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Style\Border;
use Maatwebsite\Excel\Concerns\WithMapping;
use PhpOffice\PhpSpreadsheet\Cell\DataType;
use Maatwebsite\Excel\Concerns\WithDrawings;
use Maatwebsite\Excel\Concerns\WithHeadings;

use PhpOffice\PhpSpreadsheet\Style\Alignment;
use Maatwebsite\Excel\Concerns\FromCollection;
use PhpOffice\PhpSpreadsheet\Style\Conditional;
use PhpOffice\PhpSpreadsheet\Worksheet\Drawing;
use Maatwebsite\Excel\Concerns\WithColumnWidths;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use Maatwebsite\Excel\Concerns\WithCustomStartCell;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;

class GradsExport implements FromCollection,WithColumnWidths, WithDrawings, WithEvents, WithCustomStartCell, WithHeadings, WithStyles//, WithColumnFormatting
{
    protected $pv_id;
    private $pv;
    private $section;
    private $material;
    private $teacher;
    private $period;
    private $session;
    private $scholarYear;
    private $school;
    private $typesExamsIds = [];
    private $typesExamsCols = [];
    private $typesExamsNames = [];
    private $typesExamsCoefs = [];
    private $latestLetter='I';
    private $startRow =12;
    public function __construct($pv_id)
    {
        $this->pv_id = $pv_id;
        $this->startRow = env('export_grads_start_row')?env('export_grads_start_row'):12;

    }

    public function drawings()
    {
        $drawing = new Drawing();
        $drawing->setName('Logo');
        $drawing->setDescription('');
        $drawing->setPath(public_path('images/app-logo.png'));
        $drawing->setHeight(90);
        $drawing->setCoordinates('C2');

        return $drawing;
    }

    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        $this->pv = Pv::find($this->pv_id);
        $this->section = Section::find($this->pv->section_id);
        $this->material = Material::find($this->pv->material_id);
        $this->teacher = User::find($this->pv->teacher_id);
        $this->period = Parameter::find($this->pv->period_id);
        if(env('periods_cumulatif'))
        {
        $this->period->name = $this->period->periodCumulatif($this->section->level_id, $this->period->id);
        }

        $this->session = Parameter::find($this->pv->session_id);
        $this->scholarYear = ScholarYear::find($this->pv->section->scholar_year_id);
        $this->school = School::find($this->pv->section->school_id);


        $result = Pv::where('pvs.id', $this->pv_id)
        ->join('assignments', function ($join) {
            $join->on('assignments.section_id', '=', DB::raw($this->section->id));
        })
        ->join('users as students', 'students.id', '=', 'assignments.student_id')
        ->join('type_exams_materials', 'type_exams_materials.material_id', '=', 'pvs.material_id')
        ->join('parameters as type_exams', 'type_exams.id', '=', 'type_exams_materials.type_exam_id')
        ->leftjoin('grads', function ($join) {
            $join->on('grads.pv_id', '=', 'pvs.id')
                ->where('grads.assignment_id', '=', DB::raw('assignments.id'));
        })
        ->leftjoin('grad_type_exam', function ($join) {
            $join->on('grad_type_exam.grad_id', '=', 'grads.id')
                ->where('type_exams.id', '=', DB::raw('grad_type_exam.type_exam_id'));
        })
        ->select('pvs.id as pv_id', 'assignments.id as assignment_id','students.id as student_id',  'students.first_name as student_first_name','students.last_name as student_last_name','grad_type_exam.grad as grad', 'type_exams.name as type_exam_name' , 'type_exams.id as type_exam_id', 'grads.obs', 'grads.rem')
        ->distinct()
       ->get()
        ;


        $grouped = $result->groupBy('student_id');

        // Transform grouped data into the desired format
        $collection = new Collection();
        foreach ($grouped as $student_id => $items) {
            $row = [
                'assignment_id' => $items->first()->assignment_id,
                'student_id' => $student_id,
                'student_name' => $items->first()->student_first_name . ' ' . $items->first()->student_last_name,
            ];

            // Pivot type_exam_name and grad
            foreach($this->typesExamsNames as $typeExamName){
                $row[$typeExamName] ="";
                foreach ($items as $item) {

                    if($item->type_exam_name==$typeExamName)
                    {
                        $row[$typeExamName] = $item->grad;
                    }
                }
            }
            if(env('homeworks_count_column'))
            {
                $row['rem'] = $items->first()->rem;
            }
            $row['obs'] = $items->first()->obs;
            $collection->push($row);
        }

        return $collection;
    }



    public function columnWidths(): array
    {
        return [
            'A' => 10,
            'B' => 10,
            'C' => 0,
            'D' => 20,
            'E' => 40,
            'F' => 20,
            'G' => 20,
            'H' => 20,
            'I' => 20,
            'J'=> 20,
            'K'=> 20,
            'L'=> 20,
            'M'=> 20,
            'N'=> 20,
            'O'=> 20,
            'P'=> 20,
            'Q'=> 20,
            'R'=> 20,
            'S'=> 20,
            'T'=> 20,
            'U'=> 20,
            'V'=> 20,
            'W'=> 20,
            'X'=> 20,
            'Y'=> 20,
            'Z'=> 20,
            'AA'=> 20,
            'AB'=> 20,
            'AC'=> 20,
            'AD'=> 20,
            'AE'=> 20,
            'AF'=> 20,
            'AG'=> 20,
            'AH'=> 20,
            $this->latestLetter=>50,
        ];
    }


    public function headings(): array
    {
        return [
            array_merge(['assignment_id','student id',' student name'],
            $this->typesExamsIds,
            env('homeworks_count_column')?[strtoupper(trans('Nb Homeworks'))]:[],
            ['observation']),

            array_merge([strtoupper(trans('#')),strtoupper(trans('#')), strtoupper(trans('name'))],
            $this->typesExamsNames,
            env('homeworks_count_column')?[strtoupper(trans('Nb Homeworks'))]:[],
            [strtoupper(trans('Observation'))]),

            array_merge(['','',''],$this->typesExamsCoefs,
            env('homeworks_count_column')?['']:[],
            ['']),
                        array_merge(['assignment_id',strtoupper(trans('student_id')), strtoupper(trans('name'))],
            $this->typesExamsCols,
            env('homeworks_count_column')?['REM']:[],
            [strtoupper(trans('obs'))])
    ];
    }


    public function registerEvents(): array
    {
        return [
            AfterSheet::class => function(AfterSheet $event) {
                $highestRow = $event->sheet->getHighestRow();

                $event->sheet->getRowDimension(1)->setRowHeight(0);
                $event->sheet->getRowDimension($this->startRow)->setRowHeight(0);
                $event->sheet->getRowDimension($this->startRow+3)->setRowHeight(0);
                $event->sheet->getRowDimension(2)->setRowHeight(60);

                $event->sheet->setCellValue('E2', $this->school->name);
                $event->sheet->setCellValue('C1', $this->pv->id);
                $event->sheet->setCellValue('D1', $this->section->id);
                $event->sheet->setCellValue('E1', $this->material->id);
                $event->sheet->setCellValue('F1', $this->teacher->id);
                $event->sheet->setCellValue('G1', $this->scholarYear->id);
                $event->sheet->setCellValue('H1', $this->period->id);
                $event->sheet->setCellValue('I1', $this->session->id);


                $event->sheet->setCellValue('D4', trans('section') . ' : ');
                $event->sheet->setCellValue('E4', $this->section->name);
                $event->sheet->setCellValue('D5', trans('material') . ' : ');
                $event->sheet->setCellValue('E5', $this->material->name);
                $event->sheet->setCellValue('D6', trans('teacher') . ' : ');
                $event->sheet->setCellValue('D7','* '. trans('you can modify the value of each column coefficient'));
                $event->sheet->setCellValue('D8','** '. trans('do not change the structure or the name of the file to avoid importation problems'));



                $event->sheet->setCellValue('E6', $this->teacher->id_msg);
                $event->sheet->setCellValue('F4', trans('scholar year') . ' : ');
                $event->sheet->setCellValue('G4', $this->scholarYear->name);
                $event->sheet->setCellValue('F5', trans('period') . ' : ');
                $event->sheet->setCellValue('G5', $this->period->name);
                $event->sheet->setCellValue('F6', trans('Session exam') . ' : ');
                $event->sheet->setCellValue('G6', $this->session->name);

                $event->sheet->getProtection()->setSheet(true)->setPassword('password');

                // Allow user to type data only in range F11:H60
                $event->sheet->getStyle('F11:'.$this->latestLetter.$highestRow)->getProtection()->setLocked(false);
                $event->sheet->getProtection()->setSheet(true);
            },

           BeforeSheet::class => function(BeforeSheet $event) {

            $result = Pv::where('pvs.id', $this->pv_id)
            ->join('type_exams_materials', 'type_exams_materials.material_id', '=', 'pvs.material_id')
            ->join('parameters as type_exams', 'type_exams_materials.type_exam_id', '=', 'type_exams.id')
            ->select('type_exams.name as type_exam_name' ,
            'type_exams.id as type_exam_id',
            DB::raw('CASE WHEN type_exams_materials.coef IS NOT NULL THEN type_exams_materials.coef ELSE type_exams.coefficient END as coef')
            )
            ->distinct()
            ->get();


            foreach ($result as $typeExam) {
                array_push($this->typesExamsNames, $typeExam->type_exam_name);
                array_push($this->typesExamsIds, $typeExam->type_exam_id);
                array_push($this->typesExamsCols, "col_".$typeExam->type_exam_id);
                array_push($this->typesExamsCoefs, $typeExam->coef);
            }


            $letters = range('G', 'Z'); // Array of letters from G to Z
            $count = count($this->typesExamsNames);
            $i=env('homeworks_count_column')?0:1;

            $this->latestLetter = $letters[$count - $i];




            }
        ];






    }

    public function map($row): array
    {
        // Déterminer la couleur de la ligne en fonction de la valeur de la colonne crédit
        //$rowColor = $row->montant_credit > 0 ? '008F00' : 'FF0000'; // Vert si crédit > 0, sinon rouge

        return [
            [
                $row->colC,
                $row->colD,
                NumberFormat::toFormattedString($row->colE, '0.00'),
                NumberFormat::toFormattedString($row->colF, '0.00'),
                NumberFormat::toFormattedString($row->colG, '0.00'),

            ],
           /* 'font' => [
                'color' => ['rgb' => $rowColor], // Appliquer la couleur déterminée à toute la ligne
            ]*/
        ];
    }

    public function startCell(): string
    {
        return 'C'.$this->startRow;
    }

   /* public function columnFormats(): array
    {
        return [

            'E' => '_-* #,##0.00_- ;-* #,##0.00_- ;_-* "-"??_-;_-@_-',
            'F' => '_-* #,##0.00_- ;-* #,##0.00_- ;_-* "-"??_-;_-@_-',
            'G' => '_-0.00_- ;-0.00_- ;"-0.00"_- ;@_-',
        ];
    }*/

    public function styles(Worksheet $sheet)
    {
        $highestRow = $sheet->getHighestRow();

        $styles = [


        ];

        $sheet->getStyle('E2:E2')->applyFromArray([
            'font' => [
                'bold' => true,
                'size' => 18 ,
            ]

        ]);
        $sheet->getStyle('C4:F6')->applyFromArray([
            'font' => [
                'size' => 14 ,
            ]
        ]);
 $sheet->getStyle('D4:D6')->applyFromArray([
            'font' => [
                'bold' => true,
            ]
        ]);
        $sheet->getStyle('F4:F6')->applyFromArray([
            'font' => [
                'bold' => true,
            ]
        ]);



    $sheet->getStyle('F'.($this->startRow+1).':'. $this->latestLetter . $highestRow)->applyFromArray([
        'fill' => [
            'fillType' => Fill::FILL_SOLID,
            'startColor' => ['rgb' => 'eaebec'], // Background color for notes
        ],




    ]);
    $sheet->getStyle('F'.($this->startRow+3).':'. $this->latestLetter . $highestRow)->applyFromArray([

        'numberFormat' => [
            'formatCode' => '_-* #,##0.00_- ;-* #,##0.00_- ;_-* "-"??_-;_-@_-',
        ],



    ]);
    $letters = range('G','Z');
    $index = array_search($this->latestLetter, $letters);
    $previousLetter = $letters[($index==0?1:$index)-1];

    $sheet->mergeCells('D'.($this->startRow+1).':D'.($this->startRow+2));
    $sheet->mergeCells('E'.($this->startRow+1).':E'.($this->startRow+2));

    if(env('homeworks_count_column'))
    {
        $sheet->mergeCells( $previousLetter.($this->startRow+1).':'. $previousLetter.($this->startRow+2));

        $sheet->getStyle($previousLetter.($this->startRow+1))->getAlignment()->setWrapText(true);
        $sheet->getStyle($previousLetter.($this->startRow+3).':'.$previousLetter.$highestRow)->getNumberFormat()->setFormatCode(NumberFormat::FORMAT_TEXT);

    }
    $sheet->mergeCells($this->latestLetter.($this->startRow+1).':'.$this->latestLetter.($this->startRow+2));


    $sheet->getStyle('D'.($this->startRow+1).':'.$this->latestLetter.($this->startRow+2))->applyFromArray([

            'font' => [
                'bold' => true,
                'size' => 16 ,
                'italic' => true,
                'color' => ['rgb' => 'FFFFFF']
            ],
            'fill' => [
                'fillType' => Fill::FILL_SOLID,
                'startColor' => ['rgb' => '000000'], // Background color for the first row
            ],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_CENTER,
                'vertical' => Alignment::VERTICAL_CENTER,
            ],


    ]);


    $sheet->getStyle('D'.($this->startRow+1).':D'.$highestRow)->applyFromArray([
        'alignment' => [
            'horizontal' => Alignment::HORIZONTAL_CENTER,
            'vertical' => Alignment::VERTICAL_CENTER,
        ],


]);




    $sheet->getStyle('F'.($this->startRow+2).':'.$previousLetter.($this->startRow+2))->applyFromArray([
        'font' => [
            'bold' => true,
            'size' => 16 ,
            'italic' => true,
            'color' => ['rgb' => '000000']
        ],
        'fill' => [
            'fillType' => Fill::FILL_SOLID,
            'startColor' => ['rgb' => 'eaebec'], // Background color for the first row
        ],
]);


         // Apply border styles
    $sheet->getStyle('D'.($this->startRow+1).':'.$this->latestLetter . $sheet->getHighestRow())
    ->applyFromArray([
        'borders' => [
            'outline' => [
                'borderStyle' => Border::BORDER_DOUBLE,
                'color' => ['rgb' => '000000'], // Border color
            ],
            'inside' => [
                'borderStyle' => Border::BORDER_THIN,
                'color' => ['rgb' => '000000'], // Border color
            ],
        ],
    ]);
    if(env('homeworks_count_column'))
    {
    $sheet->getStyle($previousLetter.($this->startRow+1))->applyFromArray([

        'font' => [
            'bold' => true,
            'size' => 14 ,
            'italic' => true,
            'color' => ['rgb' => 'FFFFFF']
        ]]);
        }
    return $styles;
    }


}
