import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom';
import { checkIfImage } from '../utils';
import { FormField } from '../components';

const CreateCampaign = () => {
  const [isLoading, setIsLoading] = useState(false);
  const navigate = useNavigate();
  // const {createCampaign} = useStateContext();
  const [form, setForm] = useState({
    name:'',
    title:'',
    description:'',
    target:'',
    deadline:'',
    image:''
    });
  
    const handleFormFieldChange = (fieldName, e) => {
      setForm({ ...form, [fieldName]: e.target.value })
    }
  
  const handleSubmit = async (e) => {
    e.preventDefault();

    checkIfImage(form.image, async (exists) => {
      if(exists) {
        setIsLoading(true)
        await createCampaign({ ...form, target: ethers.utils.parseUnits(form.target, 18)})
        setIsLoading(false);
        navigate('/');
      } else {
        alert('Provide valid image URL')
        setForm({ ...form, image: '' });
      }
    })
  }

  return (
    <div className="bg-[#1c1c24] flex justify-center items-center flex-col rounded-[10px] sm:p-10 p-4">
      {isLoading && 'Loading....'}
      <div className="flex justify-center items-center p-[16px] sm:min-w-[380px] bg-[#3a3a43] rounded-[10px]">
        <h1 className='font-epilogue font-semibold sm:text-[25px] leading-[38px] text-white text-[18px]'>Start a compaign</h1>
      </div>
      <form onSubmit={handleSubmit} className="w-full mt-[65px] flex flex-col gap-[30px]">
        <div className='flex flex-wrap gap-[40px]'>
          <FormField 
            labelName="Your Name *"
            placeholder = "Ujala Maurya"
            inputType = "text"
            value = "form.name"
            handleChange={()=>{}}
          />
          <FormField 
            labelName="Compaign title Name *"
            placeholder = "Write a title"
            inputType = "text"
            value = {form.title}
            handleChange={()=>{}}
          />
        </div>
        <FormField 
          labelName="Story *"
          placeholder = "Write your story"
          isTextArea
          value = {form.description}
          handleChange={()=>{}}
        />        
        </form>
    </div>
  )
}

export default CreateCampaign
