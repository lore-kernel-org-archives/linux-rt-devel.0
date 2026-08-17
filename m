Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF8442377
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984943; cv=pass; b=En6lik+xF0oINTQjba4dGPxMmBGJYGCA1No7acnCkvXKYjtcUpFNdbHmbuWz5/59hzSr4v1eUkX73kcneHVpaIu+JiH6gr4MArHER6FEPH0eL4HrSK3SLBnPrr4G6ueH3nvhmwnLRFr39V2Qd3xk33xdQXeUNOiM3rFH12oEXlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984943; c=relaxed/simple;
	bh=LWyUklPEvVde80pjWh76dXMCL5F3/0ZEcJXDwLTVAFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZ9s8zy8w6SaXyKRS0k65Do6zuP97maTcSsR886MpVpJMVuSrODZchx9FyBrc5KKrkEWbfHVhswdu/91/rc6vLfLhOM4l4LFdzW7dAZjsBG0dYdYrl0qFIzuS7qtUK+t2MAkabsMPy12baJ41xs0Cegs1VwAiZRCDJpRUTB1G/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sow43KlQ; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sow43KlQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15f020a223so507345166b.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 09:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786984939; cv=none;
        d=google.com; s=arc-20260327;
        b=a3RU55EnNaQI+bQ/IT3hSLJiPHukVap57XzbYgMo8hZGi6dzPnEli6z1lc2hmQ68Q5
         z+IdwzCNiBP/jTXFBTrXk5xNuepLeYXCG2iZNNdkK13ELCLe9zhonEx7g7j3WqATLPXu
         veofsU5L1S5XkvVzKAzjsv3vp4wZoCUyvF/2sNctMM4yYI1DsJy2IbdTzqAAhYfljbEY
         v9MXoNygDtvIz57QXDzcCLKuu/Mx6h4UmzUZ7fx9znhhK1xTle4I9TinknUgBb6qyQ8R
         kWvON/8RXDOJl4lRHa6ryKNGDhzPcGa65E4BKM0CRnYjqwO4FMF1iexut6peNRplMvsN
         nlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sFE1BA4qc8eH9yS+1O8NoVG9EEM4bsE8FwqMyw0rNK8=;
        fh=N55naymboBNN7MTvZrwaXJQy5Sc7MERDvJQpi/cdX4U=;
        b=iSuh0ywsT8bi1YGT+ZNUkrM187kAZ0XajE1wXWkgZojTBXHw+5GfyXR+VeWFZHFqOH
         NM6gt1epPg10eA9IJIf57QrJoJjpKfKqXYYakG3ctgtI+umqDXaufw5PfNo3yy7b+C4n
         bbMros78+h3P0skIZjtf/B0lmNoawCHev8N2kvRJ+t3pldtcEKyhaZ6ncYbQQod2trq0
         qInN5jj0qXPW048d0kBbhqh2BzpX1HV/8Ow0bSm76DxgyZNfgB4HRsuGDjwkX2ruwpGn
         +wGzGC1piJUS4wKgXqQwla++vaj4K00hZ/i0SdxsZeUWp0ikd9NPRbYBtI4TkvLRkv3S
         XfSw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786984939; x=1787589739; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sFE1BA4qc8eH9yS+1O8NoVG9EEM4bsE8FwqMyw0rNK8=;
        b=sow43KlQyjEui3iMcCUQRkYh85m5QAYZXZ4iwCdheFrpx9Wv+Ut7SN2PSF79hrsV+f
         kSuMIBWY8i+bx8LUx+9qXoNrOLtVdqu50vGXK3vZqo/1lkM8fOjMzDa4CEb9z2y7QnFH
         5BzAW4mi1JjQq+NM7IOwfFx2Gt9JOfDkulQVLFqXBiptjSzypnK0Jxv5h2cjqzhiXYc3
         YLGJ/IUpGff94E7U8Hr4nYU9/EX22RMY8XWWW0L6DN+z8qR+Dv2F4Vp+pgbnK4VLyy9K
         J+I/yYVDp+PJnXnrnOfTB95PWb0f8Ws8qC3MJaPXd3D4P9wgZ5Q+K0wO07XelBubPmrN
         NTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984939; x=1787589739;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFE1BA4qc8eH9yS+1O8NoVG9EEM4bsE8FwqMyw0rNK8=;
        b=OO7zpF49/x6NKFbcFxg1LVKcubYVNQ4S2YQFoyri0ct60uqud98vjN2vwfAdIO58ok
         ofrc/UcUtlwOZiKC4k7HJobLV1tQfFoxPM7F7iZUrsr+6+WRglNTaGTKQW4uJRDcBqTD
         rgo5OX7/B9qHeLBft927S0iDB8efe+Xh0nPgyRidgFRcEAkQFur25gSIJ514wLnmTB4r
         j4fEz0+xG1U3YqPEGqdFD35wT0xcKinxKtod1aA83ihm9BtZhz9IBClU9mBF8ynTRbrB
         i/6X9s1+ciWRD/4bDZwoTW5Unqgu6a26Bdo1rXWcnol6B4SgPx3XUARwAvXamy13VYlr
         C5Hw==
X-Forwarded-Encrypted: i=1; AHgh+RqiIImlxBCdnJCGxpctBF7AGhZxjBYbMOIeD+qUBoMINU75STh2QhcR4bLQzBZV7olceb8elApvz4+C2kFDJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaPKaesNIiSI99sbvtw0pGJ0BswogXMEBb7c8FiPAVVI/KSvMr
	ZDbtUezHKoz0Nlfy/5PwF1Idl44Hq2xE2gyFMP+b2XQRAr1751L0DO/zdbdgjlCGsfXUS9c4GzJ
	BR7vH7JaEn0F5jhAv4HHJZMhjmBHKcSPiFpyNG8+RCg==
X-Gm-Gg: AR+sD10ax+yK5uBitwqHaqc+odye9X4rHRGNw66qo+bra0UEfDVDPYGaSQvAaP7pTTG
	lApkMtXcrwIuyby37Q137zVPvwRXjzsBNWFyqGP7XWfHWfzY/LwfYH9gFJlIr+iHNq9UFkFeEjZ
	cqtZ82173zpqVXVP5ASf6ul1d4w7IhKsJ1JeUuTCjn/WILpBBS1hrRCDJHcR/OdtVTImnbuJYlZ
	oPqEg/7oePhtUKPMpGOPgAKe7urgobaBu89D6XeHjCDoKPc+uGGVDsMiu7PF5ejFRnP6fOV9XLx
	Smv1L3P8/vnUJZI6KW9WHqGVDCeR+4J9RR2DXvkIEuSr8OWFiyR80J00hi6gNRgehNf432ZQ6nw
	2ePM=
X-Received: by 2002:a17:906:f8d7:b0:c16:3187:997e with SMTP id
 a640c23a62f3a-c2188470cffmr67703166b.7.1786984938812; Mon, 17 Aug 2026
 09:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260813-imx_mbox_rproc-v6-1-6903a93b0456@linutronix.de>
In-Reply-To: <20260813-imx_mbox_rproc-v6-1-6903a93b0456@linutronix.de>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 17 Aug 2026 10:42:07 -0600
X-Gm-Features: AcwNN1Vjq0Onmo-OSIhb_VOVbnbnVIcFYknOXymgNiBmv90p3xsOtJFiD6hsF8A
Message-ID: <CANLsYkwc_0v-edkEd4ztbMTvkk6rWQQE1UDN5_1oraePtOvaEQ@mail.gmail.com>
Subject: Re: [PATCH REPOST REPOST v6] remoteproc: imx_rproc: Invoke the
 callback directly
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-remoteproc@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Jassi Brar <jassisinghbrar@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Peng Fan <peng.fan@nxp.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll pick this up when RC1 comes out.

Thanks,
Mathieu

On Thu, 13 Aug 2026 at 02:22, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The imx-mailbox driver moved the callback invocation into the threaded
> IRQ handler. This means the callback is invoked in preemptible context
> and there is no need to schedule the kworker for the
> imx_rproc_notified_idr_cb() invocation.
>
> This was tested with the rpmsg-tty driver on imx93.
>
> Remove the workqueue handling and invoke the imx_rproc_notified_idr_cb()
> callback directly.
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> The imx's remoteproc driver uses a kworker from its mailbox callback to
> complete the request. The reason is that the imx mailbox driver invokes
> the callback from its interrupt handler and the remoteproc callback (at
> least the rpmsg-tty) requires a preemptible context.
>
> This works but is problematic in a PREEMPT_RT environment where the
> latency of the invocation is important. By scheduling a kworker the
> high task priority from the threaded handler is lost and the kworker
> competes for CPU ressources with every SCHED_OTHER task in the system.
> This can lead to long delays on a busy system with other RT threads
> which are less important than the completion of this request.
>
> Looking over other mailbox driver, like the arm_mhu for instance, they
> use a threaded interrupt handler to invoke the callback. This avoids the
> kworker detour.
>
> The here suggested change utilises a threaded interrupt to invoke the
> callback. The primary handler mask the interrupt source so that the
> handler can run without getting interrupted by the interrupt again.
> Doing so avoids marking the interrupt IRQF_ONESHOT so that in a
> shared-interrupt environment the other interrupt can still fire while
> the first is masked.
>
> The first four patches are result of the sashiko review. Does not look
> critical.
>
> This change was tested on a im93 board with rpmsg-tty driver.
>
> v5=E2=80=A6v6: https://patch.msgid.link/20260721-imx_mbox_rproc-v5-1-6386=
a2cf8524@linutronix.de
>   - Repost. Adding Greg and akpm, hoping someone will apply it.
>
> v4=E2=80=A6v5: https://lore.kernel.org/all/20260703-imx_mbox_rproc-v4-1-6=
7b10560a861@linutronix.de/
>   - Repost
>
> v3=E2=80=A6v4: https://lore.kernel.org/r/20260617-imx_mbox_rproc-v3-0-779=
48112defc@linutronix.de
>   - The mailbox bits are part of v7.2-rc1. This is just a repost of the
>     imx_rproc driver which is left.
>
> v2=E2=80=A6v3: https://lore.kernel.org/r/20260603-imx_mbox_rproc-v2-0-a00=
59dc3b69a@linutronix.de
>   - Forward the error in imx_mu_generic_tx() to the caller (new patch
>     #1)
>   - Extend the patch description a bit for for "Start splitting the IRQ
>     handler" to briefly explain why callbacks are moved to the threaded
>     handler.
>   - Drop imx_mu_con_priv::pending. The primary handler wakes its
>     threaded handler. Once the handler is woken, the pending flag must
>     be set and there is no need to set/ clear it.
>   - Avoid the double clk_disable_unprepare() if
>     devm_mbox_controller_register() fails.
>
> v1=E2=80=A6v2: https://lore.kernel.org/r/20260529-imx_mbox_rproc-v1-0-b8f=
fc36e11e5@linutronix.de
>   - Using correct register to enable RXDB event.
>   - Update commit description for the "threaded interrupt", "unmasks the
>     interrupt" =3D> "masks the interrupt event".
>   - Add a shutdown field so that the interrupt does not unmask the
>     interrupt if it has been already disabled because the channel is
>     about to be shutdown.  A possible race mentioned by sashiko.
>   - Use devm_pm_runtime_enable(). This should avoid a possible race
>     sashiko mentioned.
>   - Use devm_of_platform_populate().
> ---
>  drivers/remoteproc/imx_rproc.c | 33 +--------------------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
> index 7662ebd9d2f49..e18ae33a5cf85 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -24,7 +24,6 @@
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
>  #include <linux/scmi_imx_protocol.h>
> -#include <linux/workqueue.h>
>
>  #include "imx_rproc.h"
>  #include "remoteproc_internal.h"
> @@ -115,8 +114,6 @@ struct imx_rproc {
>         struct mbox_client              cl;
>         struct mbox_chan                *tx_ch;
>         struct mbox_chan                *rx_ch;
> -       struct work_struct              rproc_work;
> -       struct workqueue_struct         *workqueue;
>         void __iomem                    *rsc_table;
>         struct imx_sc_ipc               *ipc_handle;
>         struct notifier_block           rproc_nb;
> @@ -892,21 +889,11 @@ static int imx_rproc_notified_idr_cb(int id, void *=
ptr, void *data)
>         return 0;
>  }
>
> -static void imx_rproc_vq_work(struct work_struct *work)
> -{
> -       struct imx_rproc *priv =3D container_of(work, struct imx_rproc,
> -                                             rproc_work);
> -       struct rproc *rproc =3D priv->rproc;
> -
> -       idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc)=
;
> -}
> -
>  static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
>  {
>         struct rproc *rproc =3D dev_get_drvdata(cl->dev);
> -       struct imx_rproc *priv =3D rproc->priv;
>
> -       queue_work(priv->workqueue, &priv->rproc_work);
> +       idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc)=
;
>  }
>
>  static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
> @@ -1271,13 +1258,6 @@ static int imx_rproc_sys_off_handler(struct sys_of=
f_data *data)
>         return NOTIFY_DONE;
>  }
>
> -static void imx_rproc_destroy_workqueue(void *data)
> -{
> -       struct workqueue_struct *workqueue =3D data;
> -
> -       destroy_workqueue(workqueue);
> -}
> -
>  static int imx_rproc_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -1305,17 +1285,6 @@ static int imx_rproc_probe(struct platform_device =
*pdev)
>                 priv->ops =3D dcfg->ops;
>
>         dev_set_drvdata(dev, rproc);
> -       priv->workqueue =3D create_workqueue(dev_name(dev));
> -       if (!priv->workqueue) {
> -               dev_err(dev, "cannot create workqueue\n");
> -               return -ENOMEM;
> -       }
> -
> -       ret =3D devm_add_action_or_reset(dev, imx_rproc_destroy_workqueue=
, priv->workqueue);
> -       if (ret)
> -               return dev_err_probe(dev, ret, "Failed to add devm destro=
y workqueue action\n");
> -
> -       INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
>
>         ret =3D imx_rproc_xtr_mbox_init(rproc, true);
>         if (ret)
>
> ---
> base-commit: 2ee859ebf156157609f71060ae472711c8cbc326
> change-id: 20260529-imx_mbox_rproc-7d512f5a6f78
>
> Best regards,
> --
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
