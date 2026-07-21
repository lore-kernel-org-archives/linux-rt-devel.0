Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4064D90CC
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646881; cv=none; b=UFUExj0iBgZRiu2VYcvEGkSLqRtANbzpaZLDWi8W5oLpJw60/8BGbJjOyTGjnCjCfdlcSKlBQ2M6fwmJxmcQoTFsoxvwiI9fN/DL6bZxTQ1VNnq98xRQ/Gyw7MgeRTqNYbAyDXJKfD3CnvMzLFg+K/71wDf9feNRfT7vnJEq1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646881; c=relaxed/simple;
	bh=dcvWL694LiuZkymBYI79WUNwhSlu6FHKFwvtl5wq/Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZr8RflA/IpDiKMdcDjmpryq7Pa9VbQqMOHcFHxa5mRoGqkmSg6PsGKyeox1F1c7TCFDvHuqDCEVXx6SzsyklhUztsKaouNbpXzbdYPxcCEL91wxR01q377ZrBA6ONEGb8EeTuU+fgw9cUODLhbfy1yCpXNGG9VwXiJ3AamR5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SAvsZgsw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAvsZgsw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caea3f742bso136923515ad.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784646878; x=1785251678; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0NzLnpEpcxO5DD6T26b2jUHl7f+urYYWu7UR8jPYSDY=;
        b=SAvsZgswKNTrsuhcRmUfShkUospLZwW2xZkFLYyn/GjnZ3amSXjoXpfp0e7DdbM4G1
         hYvNdZrc5W33fFOIr/LbG00rIxlS8baxZN1EIRx6EeYI5+kCwlxhZQNLTpFz7FhnBUjZ
         TQXjoXzSXnAn9yVLwJ4BjwEkeO0FdgJnPwhMCy5qIhHDhAnjtXPHNbBX8U/gxiauvgQx
         fGsYrEGR98SLMXB1HZjEyG5OHyySM7AlyHu4n3gwt4ZBZ8iLRJPdbb1sD1hw2yFDoybt
         RUIrV6iLmAHfLT9Z9BooPP5prglNgmO8CqvX4rXOFRUtlnJX9v2TZOPooNkkjABmnlUb
         HeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784646878; x=1785251678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0NzLnpEpcxO5DD6T26b2jUHl7f+urYYWu7UR8jPYSDY=;
        b=BZKOWe3UIfJ4CRk15qxcDA70gJynN+BLNtAva1Ay6iklDMkQuQHH8QyHw/OcKXa8wR
         4vpoN9FEf8zB9qK/X/EBi4BfStlpQCO26MC86FfBYXTwLkiQN+LyUaIYTIhWXI8WTul9
         6RzTevdVLnxh9OrZxyifNkx8gF8hJhpmu3pNxJYHTYlPAcrXYn0OK9PeCsmiSyyayvpG
         XED/JnG6kNhU1onnOuAQzVlovf9MgXQBrN7oEhqBV3FpgG6Lkjty6LsUQjOtXo/taPyC
         cYvSaXApJeXHl67CbJXWnuzwUYo490Q0exwhh1qj3tkQgqHIPmfCcGtCNy0btxwAceum
         1saA==
X-Forwarded-Encrypted: i=1; AHgh+Rqg6DvD4b7YkhlNwaxZMv3MspJgUP3VG9yKZWZzL5WbRcjf15lphGwIHNgKZws7O1Wrg09afn6UkZNU+ixjsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaDDPlfpBfYcudLTa9DlmxN9vxVewSSJ33xYTxLPoKEailEPUz
	59cwOKliJD7mXYLpGNcO+IZP9Gsn+HlUxylKkqQ9/ZV7vKGcpgGv8FK7AqRiqbwp4+o=
X-Gm-Gg: AR+sD13saJZ13ReNFRNcCjyN/eARVmlVrq3+bhfux4pkSQyMeHsQWc43ksqwhVE98VL
	vmChjC3T+pLhNqqDkzcDnbVRTrSYct47298re84O/4MbzE98mIb2RcjkTXEVai9WdCFv6d5f/WP
	NVvl+PaoICnm0ulU71oBDe05SNKk2LyWwuGczdaHFrjiekPHhpA0XZjEPFnmDzLo7YHp0qqePgP
	dYxcJCvI+9I9h1jSv/E6PfiNLf2qNQJXctXuAX/O0o3LStahztqetWN66nxXKFTv2hH7S1ms27z
	UwpmgHyzJcNNCYncyWN0mEIGZH0vAcY2F7/kHCadbD5dZ75hyu0Jwrmg2ITHvC7dl+7hsYohcwY
	Jl6EHBILdmqobLJZm/zv2xekzx0b3KqiD9/iXSfxR5OsDgKbmRl+CevHE3Zztm2HohQZpJEsPa2
	+3M+tamg==
X-Received: by 2002:a17:902:f681:b0:2c9:a9c0:80b6 with SMTP id d9443c01a7336-2cf34a48e5dmr210192335ad.34.1784646878053;
        Tue, 21 Jul 2026 08:14:38 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d5fc:59b3:7d06:7bd9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ef6asm78278065ad.9.2026.07.21.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 08:14:37 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:14:35 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Bjorn Andersson <andersson@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 REPOST] remoteproc: imx_rproc: Invoke the callback
 directly
Message-ID: <al-M2xoMM9P_DKK_@p14s>
References: <20260721-imx_mbox_rproc-v5-1-6386a2cf8524@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-imx_mbox_rproc-v5-1-6386a2cf8524@linutronix.de>

On Tue, Jul 21, 2026 at 04:09:06PM +0200, Sebastian Andrzej Siewior wrote:
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

Jassi - can you pick this up?

> ---
> This change was tested on a im93 board with rpmsg-tty driver.
> 
> v4…v5: https://lore.kernel.org/all/20260703-imx_mbox_rproc-v4-1-67b10560a861@linutronix.de/
>   - Repost
>
> v3…v4: https://lore.kernel.org/r/20260617-imx_mbox_rproc-v3-0-77948112defc@linutronix.de
>   - The mailbox bits are part of v7.2-rc1. This is just a repost of the
>     imx_rproc driver which is left.
>    
> v2…v3: https://lore.kernel.org/r/20260603-imx_mbox_rproc-v2-0-a0059dc3b69a@linutronix.de
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
> v1…v2: https://lore.kernel.org/r/20260529-imx_mbox_rproc-v1-0-b8ffc36e11e5@linutronix.de
>   - Using correct register to enable RXDB event.
>   - Update commit description for the "threaded interrupt", "unmasks the
>     interrupt" => "masks the interrupt event".
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
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
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
>  	struct mbox_client		cl;
>  	struct mbox_chan		*tx_ch;
>  	struct mbox_chan		*rx_ch;
> -	struct work_struct		rproc_work;
> -	struct workqueue_struct		*workqueue;
>  	void __iomem			*rsc_table;
>  	struct imx_sc_ipc		*ipc_handle;
>  	struct notifier_block		rproc_nb;
> @@ -892,21 +889,11 @@ static int imx_rproc_notified_idr_cb(int id, void *ptr, void *data)
>  	return 0;
>  }
>  
> -static void imx_rproc_vq_work(struct work_struct *work)
> -{
> -	struct imx_rproc *priv = container_of(work, struct imx_rproc,
> -					      rproc_work);
> -	struct rproc *rproc = priv->rproc;
> -
> -	idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);
> -}
> -
>  static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
>  {
>  	struct rproc *rproc = dev_get_drvdata(cl->dev);
> -	struct imx_rproc *priv = rproc->priv;
>  
> -	queue_work(priv->workqueue, &priv->rproc_work);
> +	idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);
>  }
>  
>  static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
> @@ -1271,13 +1258,6 @@ static int imx_rproc_sys_off_handler(struct sys_off_data *data)
>  	return NOTIFY_DONE;
>  }
>  
> -static void imx_rproc_destroy_workqueue(void *data)
> -{
> -	struct workqueue_struct *workqueue = data;
> -
> -	destroy_workqueue(workqueue);
> -}
> -
>  static int imx_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1305,17 +1285,6 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  		priv->ops = dcfg->ops;
>  
>  	dev_set_drvdata(dev, rproc);
> -	priv->workqueue = create_workqueue(dev_name(dev));
> -	if (!priv->workqueue) {
> -		dev_err(dev, "cannot create workqueue\n");
> -		return -ENOMEM;
> -	}
> -
> -	ret = devm_add_action_or_reset(dev, imx_rproc_destroy_workqueue, priv->workqueue);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to add devm destroy workqueue action\n");
> -
> -	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
>  
>  	ret = imx_rproc_xtr_mbox_init(rproc, true);
>  	if (ret)
> 
> ---
> base-commit: b3f94b2b3f3e51ab880a51fc6510e1dafba654ed
> change-id: 20260529-imx_mbox_rproc-7d512f5a6f78
> 
> Best regards,
> -- 
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
