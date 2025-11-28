function NotifyClient(src, message, notifyType, duration)
    BccUtils.RPC:Notify("bcc-farming:NotifyClient", {
        message = message,
        type = notifyType or "info",
        duration = duration or 4000
    }, src)
end
