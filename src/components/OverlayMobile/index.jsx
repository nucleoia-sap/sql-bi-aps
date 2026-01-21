export const OverlayMobile = ({ isOpen, onClose }) => {

    if (!isOpen) return null;

    return (
        <div
            onClick={onClose}
            className="fixed inset-0 bg-black/50 z-30 md:hidden"
        />
    )
}