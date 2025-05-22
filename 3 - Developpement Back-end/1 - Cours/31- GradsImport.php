<?php

namespace App\Imports;

use App\Models\Exams\Pv;
use App\Models\Exams\Grad;
use App\Models\Exams\GradTypeExam;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Events\BeforeImport;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\RegistersEventListeners;

class GradsImport implements ToModel,WithEvents,WithHeadingRow
{
    private $pv_id;
    private $section_id;
    private $material_id;
    private $teacher_id;
    private $scholar_year_id;
    private $period_id;
    private $session_id;
    private $startRow=12;
    private $coefs = [];
    private $typesExams = [];

    public function __construct()
    {

        $this->startRow = env('export_grads_start_row')?env('export_grads_start_row'):12;

    }

    public function registerEvents(): array
    {
        return [
            BeforeImport::class => function(BeforeImport $event) {
                //$creator = $event->reader->getProperties()->getCreator();
                $letters = range('A', 'Z');
                $index = '5';



              //  $this->pv_id =$event->reader->getDelegate()->getActiveSheet()->getCell('C1')->getValue();




                $this->section_id =$event->reader->getDelegate()->getActiveSheet()->getCell('D1')->getValue();
                $this->material_id =$event->reader->getDelegate()->getActiveSheet()->getCell('E1')->getValue();
                $this->teacher_id =$event->reader->getDelegate()->getActiveSheet()->getCell('F1')->getValue();
                $this->scholar_year_id =$event->reader->getDelegate()->getActiveSheet()->getCell('G1')->getValue();
                $this->period_id =$event->reader->getDelegate()->getActiveSheet()->getCell('H1')->getValue();
                $this->session_id =$event->reader->getDelegate()->getActiveSheet()->getCell('I1')->getValue();

            $pv = Pv::where('section_id',$this->section_id)
            ->where('material_id',$this->material_id)
            ->where('teacher_id',$this->teacher_id)
            ->where('period_id',$this->period_id)
            ->where('session_id',$this->session_id)
            ->first();
            if (!$pv)
            {
                $pv = new Pv();
                $pv->section_id = $this->section_id;
                $pv->material_id = $this->material_id;
                $pv->teacher_id = $this->teacher_id;
                $pv->period_id = $this->period_id;
                $pv->session_id = $this->session_id;
                $pv->save();

            }
            $this->pv_id = $pv->id;

                $req ="delete from grad_type_exam where grad_id in (select id from grads where  pv_id = ".$this->pv_id.");";
                DB::statement($req);
                $req = "delete  from grads where pv_id = ".$this->pv_id.";";
                DB::statement($req);

                $typeexam =$event->reader->getDelegate()->getActiveSheet()->getCell($letters[$index].$this->startRow+3)->getValue();
                while(strpos($typeexam, 'col') === 0)
                {
                    $coef =$event->reader->getDelegate()->getActiveSheet()->getCell($letters[$index].$this->startRow+2)->getValue();
                    $this->typesExams[] = $typeexam;
                    $this->coefs[] = $coef;
                    $index++;
                    $typeexam =$event->reader->getDelegate()->getActiveSheet()->getCell($letters[$index].$this->startRow+3)->getValue();

                }

                foreach($this->typesExams as $index => $typeexam)
                {
                    $req = "update type_exams_materials set coef = ".$this->coefs[$index]. " where material_id = " . $this->material_id . " and type_exam_id = " . str_replace('col_', '', $typeexam) .";";
                    DB::statement($req);
                }




            },
        ];
    }

/*

foreach (json_decode($data) as $d){

        $pv_id=$d->pv_id;
        $student_id=$d-> student_id;
        $grads=$d->grads;
        $remarque=$d->remarque;

        $observation=$d->observation;





            $pv=Pv::find($pv_id);
            $assignment = Assignment::where("assignments.student_id",$student_id)
            ->join("sections","assignments.section_id","=","sections.id")
            ->where("sections.id",$pv->section->id)
            ->whereNull("sections.deleted_by_id")
            ->select("assignments.id as id")
            ->first();
            if($assignment)
            {

               // dd($assignment->id);
                if($remarque ||$observation || count($grads)>0  )
                {
                    $grad = Grad::where("pv_id",$pv_id)->where("assignment_id",$assignment->id)->first();
                    if(!$grad)
                    {
                        $grad = new Grad();
                    }

                    $sum = 0;
                    $n = 0;
                    if($grads)
                    foreach ($grads as $g)
                    {
                        $sum+=floatval($g->grad);
                        $n++;
                    }



                    $grad->assignment_id = $assignment->id;
                    $grad->pv_id = $pv_id;
                    if($n!=0)
                        $grad->grad = $sum/$n;
                    else
                        $grad->grad = null;

                    $grad->obs = $observation;
                    $grad->rem = $remarque;
                    $grad->save();
                    if($grads)

                        foreach ($grads as $g)
                        {
                          // if($g->grad!="")
                            {
                                    $gradtypeexam = GradTypeExam::where("grad_id",$grad->id)->where("type_exam_id",$g->typeexam)->first();
                                    if(!$gradtypeexam)
                                    {
                                        $gradtypeexam =new GradTypeExam();
                                    }

                                    $gradtypeexam->grad =$g->grad!=""?$g->grad:null;
                                    $gradtypeexam->grad_id =$grad->id;
                                    $gradtypeexam->type_exam_id =$g->typeexam;
                                    $gradtypeexam->save();
                            }


}
else
{
    $gradtypeexams = GradTypeExam::where("grad_id",$grad->id)->where("type_exam_id",$g->typeexam)->get();
    if(count($gradtypeexams)>0)
        foreach($gradtypeexams as $g)
        {
            $g->delete();
        }
}
}
else
{
$grad = Grad::where("pv_id",$pv_id)->where("assignment_id",$assignment->id)->first();
if($grad)
{
    $gradtypeexams = GradTypeExam::where("grad_id",$grad->id)->get();
    if(count($gradtypeexams)>0)
        foreach($gradtypeexams as $g)
        {
            $g->delete();
        }
    $grad->delete();
}
}
}

}



*/




    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {


//dd($row);

       $sum = 0;
       $avg=null;
       $coef = 0;
       foreach($this->typesExams as $index => $typeexam)
       {

        if($row[$typeexam]!="")
        {
            $sum+=(is_numeric($row[$typeexam]) ? $row[$typeexam] * $this->coefs[$index] : 0);
            $coef+=$this->coefs[$index];
        }

       }
        if($coef!=0)
          {
              $avg = $sum/$coef;
          }
        $grad = new Grad();
        $grad->assignment_id = $row['assignment_id'];
        $grad->pv_id = $this->pv_id;
        if(array_key_exists('rem', $row))
        {
            $grad->rem = $row['rem'];
        }
        $grad->obs = $row['obs'];
        $grad->save();

        foreach($this->typesExams as $index => $typeexam)
        {
        $gradtypeexam =new GradTypeExam();
        $gradtypeexam->grad =$row[$typeexam];
        $gradtypeexam->grad_id =$grad->id;
        $gradtypeexam->type_exam_id =str_replace('col_', '', $typeexam);
        $gradtypeexam->save();
        }


    }

    public function headingRow(): int
    {
        return $this->startRow+3;
    }


}
