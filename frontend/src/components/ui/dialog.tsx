import * as Dialog from "@radix-ui/react-dialog";
export default function Modal({open,onOpenChange,title,children}:{open:boolean;onOpenChange:(o:boolean)=>void;title:string;children:React.ReactNode;}){
  return (
    <Dialog.Root open={open} onOpenChange={onOpenChange}>
      <Dialog.Portal>
        <Dialog.Overlay className="fixed inset-0 bg-black/40 data-[state=open]:animate-in" />
        <Dialog.Content className="fixed inset-0 grid place-items-center p-4">
          <div className="w-full max-w-lg rounded-2xl bg-white shadow-xl">
            <div className="flex items-center justify-between border-b px-5 py-3">
              <Dialog.Title className="font-semibold">{title}</Dialog.Title>
              <Dialog.Close className="rounded p-1 hover:bg-zinc-100">✕</Dialog.Close>
            </div>
            <div className="p-5">{children}</div>
          </div>
        </Dialog.Content>
      </Dialog.Portal>
    </Dialog.Root>
  );
}
