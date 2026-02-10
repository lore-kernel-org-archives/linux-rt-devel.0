Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9993876DB
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Feb 2026 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747280; cv=none; b=HlbNrPHf+/m8G/40Bud8Ih+LR5Ku4K8XURLAK3y7oH3rwRyf6TcEp+yuj0sACBa4qo3bMcIM9p9pXQhkxEWiJG14StS975BEwA1bB5fOY8TzS+lzDqqFLE8hdUKSw49KE/2nqtyAi4FaRBsNO5k+D6AXBLKPH/dQlXVOHN9CHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747280; c=relaxed/simple;
	bh=+5OuKNJEyDSDi742StxrHwwijmjVrOkSLbaOMV0muqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvTFp3/EpuyYqrUAVMskaVZi/LE8uNq1XMjWzq3FvGm/WKq/hMbX7itgE9MEYZpBizjXUcftzlKWeE1ctzeLshWycklYUps6/evFL5XHCKjpdmz8SPRLJpN5G5UWbK9i0YttoVTvNzDXM7LM02qTGw+TdGSEUnQDL24rWvgCeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=blUr1uj3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="blUr1uj3"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 8E7BC838;
	Tue, 10 Feb 2026 19:13:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770747231;
	bh=+5OuKNJEyDSDi742StxrHwwijmjVrOkSLbaOMV0muqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blUr1uj3x/Bj7lqY4nBUTcs83DYqv/8V7sJ3cDaWhbEqoCuT6SJihiOYlxe75+i5c
	 ZTAN516KUrg4aSVnTYExrGPm1736Xn/noHpqOl3fJJ7sOys129Y+OmvTNv52wMCJGS
	 Mob4qtfadjkqt7bmjTW7zEK5f3YeTF6trQLqIYEA=
Date: Tue, 10 Feb 2026 20:14:36 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Stefan Klug <stefan.klug@ideasonboard.com>
Cc: Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: Re: [PATCH v3 4/4] media: dw100: Merge dw100_device_run and
 dw100_start
Message-ID: <20260210181436.GE2502896@killaraus.ideasonboard.com>
References: <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-0-2eb5685eaf09@ideasonboard.com>
 <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-4-2eb5685eaf09@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-4-2eb5685eaf09@ideasonboard.com>

On Thu, Jan 29, 2026 at 12:43:13PM +0100, Stefan Klug wrote:
> The dw100_start() function is only called from dw100_device_run(). As
> both functions are not too big, move the code directly into
> dw100_device_run() and drop dw100_start() to improve readability.
> 
> This patch contains no functional changes.
> 
> Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v3:
> - Added this patch as proposed in the review of v1
> ---
>  drivers/media/platform/nxp/dw100/dw100.c | 61 ++++++++++++++------------------
>  1 file changed, 27 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
> index 46e3a7b74fb777aa479110a52229f36b8632db44..c7c4249f5769467fb2b1f3c87f5685c4463a0a9d 100644
> --- a/drivers/media/platform/nxp/dw100/dw100.c
> +++ b/drivers/media/platform/nxp/dw100/dw100.c
> @@ -1442,25 +1442,42 @@ static irqreturn_t dw100_irq_thread_fn(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void dw100_start(struct dw100_ctx *ctx, struct vb2_v4l2_buffer *in_vb,
> -			struct vb2_v4l2_buffer *out_vb)
> +static void dw100_device_run(void *priv)
>  {
> +	struct dw100_ctx *ctx = priv;
>  	struct dw100_device *dw_dev = ctx->dw_dev;
> +	struct vb2_v4l2_buffer *src_buf, *dst_buf;
>  
> -	out_vb->sequence =
> -		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)->sequence++;
> -	in_vb->sequence =
> +	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> +	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> +
> +	v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
> +				&ctx->hdl);
> +
> +	if (src_buf->vb2_buf.req_obj.req)
> +		dw100_update_mapping(ctx);
> +	else if (ctx->user_map_is_dirty)
> +		dev_warn_once(&dw_dev->pdev->dev,
> +			      "V4L2 requests are required to update the vertex map dynamically"
> +		);
> +
> +	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
> +				   &ctx->hdl);
> +
> +	src_buf->sequence =
>  		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)->sequence++;
> +	dst_buf->sequence =
> +		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)->sequence++;
>  
> -	dev_dbg(&ctx->dw_dev->pdev->dev,
> +	dev_dbg(&dw_dev->pdev->dev,
>  		"Starting queues %p->%p, sequence %u->%u\n",
>  		v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
>  				V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE),
>  		v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
>  				V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE),
> -		in_vb->sequence, out_vb->sequence);
> +		src_buf->sequence, dst_buf->sequence);
>  
> -	v4l2_m2m_buf_copy_metadata(in_vb, out_vb);
> +	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf);
>  
>  	/* Now, let's deal with hardware ... */
>  	dw100_hw_master_bus_disable(dw_dev);
> @@ -1469,10 +1486,10 @@ static void dw100_start(struct dw100_ctx *ctx, struct vb2_v4l2_buffer *in_vb,
>  	dw100_hw_set_src_crop(dw_dev, &ctx->q_data[DW100_QUEUE_SRC],
>  			      &ctx->q_data[DW100_QUEUE_DST]);
>  	dw100_hw_set_source(dw_dev, &ctx->q_data[DW100_QUEUE_SRC],
> -			    &in_vb->vb2_buf);
> +			    &src_buf->vb2_buf);
>  	dw100_hw_set_destination(dw_dev, &ctx->q_data[DW100_QUEUE_DST],
>  				 ctx->q_data[DW100_QUEUE_SRC].fmt,
> -				 &out_vb->vb2_buf);
> +				 &dst_buf->vb2_buf);
>  	dw100_hw_set_mapping(dw_dev, ctx->map_dma,
>  			     ctx->map_width, ctx->map_height);
>  	dw100_hw_enable_irq(dw_dev);
> @@ -1482,30 +1499,6 @@ static void dw100_start(struct dw100_ctx *ctx, struct vb2_v4l2_buffer *in_vb,
>  	dw100_hw_master_bus_enable(dw_dev);
>  }
>  
> -static void dw100_device_run(void *priv)
> -{
> -	struct dw100_ctx *ctx = priv;
> -	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> -
> -	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> -	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> -
> -	v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
> -				&ctx->hdl);
> -
> -	if (src_buf->vb2_buf.req_obj.req)
> -		dw100_update_mapping(ctx);
> -	else if (ctx->user_map_is_dirty)
> -		dev_warn_once(&ctx->dw_dev->pdev->dev,
> -			      "V4L2 requests are required to update the vertex map dynamically"
> -		);
> -
> -	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
> -				   &ctx->hdl);
> -
> -	dw100_start(ctx, src_buf, dst_buf);
> -}
> -
>  static const struct v4l2_m2m_ops dw100_m2m_ops = {
>  	.device_run	= dw100_device_run,
>  };

-- 
Regards,

Laurent Pinchart
