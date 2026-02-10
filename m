Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05638A29A
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Feb 2026 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747203; cv=none; b=ov1wzbxXgx00B4fus6lqMQJmQvS5a/FdCEQX6eMCpoTgpPKOQ6Fm0cp3YLeZ890jFAPMIGuLeXCDTzxjT+6w2p1KUEYMjbo3bg0h0gh+0fpR4HnrXSSK/OrglMpELrnG+UoxKX2HpdFgxkhtYoUIh3Hzcl1gt6oxNYyZSBiDkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747203; c=relaxed/simple;
	bh=/PQrQvPYhWxWw4TfuZp8xwSYNMLt/qw17myRSBEFM3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9lhtP6IUliDWohqDaN3nHXNMQr7kwPwYg9kMpihKK1MCNLoUaRspJHoRUo1/m66im/38pne+OcyOr8aRPMBjnes03Jjau4zKZWTnrysNgBmFOBLK/Hmb4a9jAKGW+wFMPPjBxU+q03aWRbP/y8U0E5jik80FdATN/1VIFXVKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dr7hT20y; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dr7hT20y"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CEDC0838;
	Tue, 10 Feb 2026 19:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770747154;
	bh=/PQrQvPYhWxWw4TfuZp8xwSYNMLt/qw17myRSBEFM3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dr7hT20ypF7Ud2bxdL43CkeaJCmuUI+gKbJoVTIgwuUpPgzY8LMdKzcZjRGVcs+Mp
	 IfGRjoXQ/Q1Yi8pA0kIll/GkIXEQRFQaLOJd90RBZI9GrUD5ACr7lsN2tSoE7kybfK
	 dpjdACfX9scjSTFAPmS6eSai/fakcH+MrNE0VvXE=
Date: Tue, 10 Feb 2026 20:13:18 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Stefan Klug <stefan.klug@ideasonboard.com>
Cc: Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: Re: [PATCH v3 3/4] media: dw100: Fix kernel oops with PREEMPT_RT
 enabled
Message-ID: <20260210181318.GD2502896@killaraus.ideasonboard.com>
References: <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-0-2eb5685eaf09@ideasonboard.com>
 <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-3-2eb5685eaf09@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-3-2eb5685eaf09@ideasonboard.com>

Hi Stefan,

Thank you for the patch.

On Thu, Jan 29, 2026 at 12:43:12PM +0100, Stefan Klug wrote:
> On kernels with PREEMPT_RT enabled, a "BUG: scheduling while atomic"
> kernel oops occurs inside dw100_irq_handler -> vb2_buffer_done. This is
> because vb2_buffer_done takes a spinlock which is not allowed within
> interrupt context on PREEMPT_RT.
> 
> The first attempt to fix this was to just drop the IRQF_ONESHOT so that
> the interrupt is handled threaded on PREEMPT_RT systems. This introduced
> a new issue. The dw100 has an internal timeout counter that is gated by
> the DW100_BUS_CTRL_AXI_MASTER_ENABLE bit. Depending on the time it takes
> for the threaded handler to run and the geometry of the data being
> processed it is possible to reach the timeout resulting in
> DW100_INTERRUPT_STATUS_INT_ERR_TIME_OUT being set and "dw100
> 32e30000.dwe: Interrupt error: 0x1" errors in dmesg.
> 
> To properly fix that, split the interrupt into two halves, reset the
> DW100_BUS_CTRL_AXI_MASTER_ENABLE bit in the hard interrupt handler and
> do the v4l2 buffer handling in the threaded half. The IRQF_ONESHOT can
> still be dropped as the interrupt gets disabled in the hard handler and
> will only be reenabled on the next dw100_device_run which will not be
> called before the current job has finished.

It worries me a bit that we're essentially relying on luck to avoid the
timeout. I'm also wondering if we couldn't just ignore the timeout
interrupt, but that's something we should investigate separately. This
patch fixes a real issue without any real drawback, so I think we can
merge it as a first step.

> Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>
> ---
> 
> Thank you Xavier for the technical support and further details on the
> interrupt bit.
> 
> Changes in v3:
> - Split interrupt in two halves to prevent timeout error
> - Dropped rby tags, as the patch changed substantially
> 
> Changes in v2:
> - Dropped the IRQF_ONESHOT instead of making the interrupt handler
>   threaded to fix the issue.
> - I didn't keep the r-by tag from Nicolas as the solution is now a
>   different one.
> ---
>  drivers/media/platform/nxp/dw100/dw100.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
> index d2b1c62b52db47ea1d2242caaf334fff30c6f366..46e3a7b74fb777aa479110a52229f36b8632db44 100644
> --- a/drivers/media/platform/nxp/dw100/dw100.c
> +++ b/drivers/media/platform/nxp/dw100/dw100.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
>  #include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
>  #include <linux/io.h>

irqreturn goes after io

With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  #include <linux/minmax.h>
>  #include <linux/module.h>
> @@ -74,6 +75,7 @@ struct dw100_device {
>  	struct clk_bulk_data		*clks;
>  	int				num_clks;
>  	struct dentry			*debugfs_root;
> +	bool				frame_failed;
>  };
>  
>  struct dw100_q_data {
> @@ -1406,7 +1408,8 @@ static irqreturn_t dw100_irq_handler(int irq, void *dev_id)
>  {
>  	struct dw100_device *dw_dev = dev_id;
>  	u32 pending_irqs, err_irqs, frame_done_irq;
> -	bool with_error = true;
> +
> +	dw_dev->frame_failed = true;
>  
>  	pending_irqs = dw_hw_get_pending_irqs(dw_dev);
>  	frame_done_irq = pending_irqs & DW100_INTERRUPT_STATUS_INT_FRAME_DONE;
> @@ -1414,7 +1417,7 @@ static irqreturn_t dw100_irq_handler(int irq, void *dev_id)
>  
>  	if (frame_done_irq) {
>  		dev_dbg(&dw_dev->pdev->dev, "Frame done interrupt\n");
> -		with_error = false;
> +		dw_dev->frame_failed = false;
>  		err_irqs &= ~DW100_INTERRUPT_STATUS_INT_ERR_STATUS
>  			(DW100_INTERRUPT_STATUS_INT_ERR_FRAME_DONE);
>  	}
> @@ -1427,7 +1430,14 @@ static irqreturn_t dw100_irq_handler(int irq, void *dev_id)
>  	dw100_hw_clear_irq(dw_dev, pending_irqs |
>  			   DW100_INTERRUPT_STATUS_INT_ERR_TIME_OUT);
>  
> -	dw100_job_finish(dw_dev, with_error);
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t dw100_irq_thread_fn(int irq, void *dev_id)
> +{
> +	struct dw100_device *dw_dev = dev_id;
> +
> +	dw100_job_finish(dw_dev, dw_dev->frame_failed);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1593,8 +1603,9 @@ static int dw100_probe(struct platform_device *pdev)
>  
>  	pm_runtime_put_sync(&pdev->dev);
>  
> -	ret = devm_request_irq(&pdev->dev, irq, dw100_irq_handler, IRQF_ONESHOT,
> -			       dev_name(&pdev->dev), dw_dev);
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, dw100_irq_handler,
> +					dw100_irq_thread_fn, 0,
> +					dev_name(&pdev->dev), dw_dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
>  		goto err_pm;

-- 
Regards,

Laurent Pinchart
