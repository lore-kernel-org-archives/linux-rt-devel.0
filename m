Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387EE35CB66
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Mar 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639443; cv=none; b=ayRpGO7Gl6Sraa9x4QJ0UVCPjwVk+pvcwY1tV+yrsFwh/thzkwl8Xr+1B026WV1vWeVRL1AZHnDmikXDbV6eueiOOxl+FwHdi5hoBkJe9v6jjZHaO/+hz0OrMQcH0HmY3tW7ficMbmDhTTyrBgGe7EHi8ZiVxQUQMwqpidl2ki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639443; c=relaxed/simple;
	bh=CligL5eiODQ5qooKmwR0FQSVQf6DUMvzCV/mukAsyyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EW4xEdB84Br5z+6CJ/G2iPaHdhPTVYP9f6QFIcxXUNxoBWYzWoC6uo8qcr1w6LAO3hGjciodgygixZ6DPFiFmcRb7XJ9GH7zu00X8PucAIPmfJWtfv0Vci8zi/5aZ0r/1oJXMsBwIBufZNRhXQvi2Vw1mIQx5ZXh87dxblMWEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FqK9vSxb; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FqK9vSxb"
Received: from ideasonboard.com (unknown [IPv6:2a00:6020:448c:6c00:404d:d4e8:ffdc:3995])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CD65310B6;
	Wed,  4 Mar 2026 16:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1772639375;
	bh=CligL5eiODQ5qooKmwR0FQSVQf6DUMvzCV/mukAsyyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FqK9vSxbgMv7HBa1uPO096Lw/Ffy4BTlbjAXXzIPvvID564tA5Ka13YQ4MI0xRuBV
	 ssgHF7y7r7gAmSjTtHu3Dn5dvt6794oM/AK8675vxdki3BYgZlZZoRx0GnnIVTqLR/
	 8Pi06EAB3PrYsXHOe+zHt9BxMRHINIcsi1oEGpaQ=
From: Stefan Klug <stefan.klug@ideasonboard.com>
Date: Wed, 04 Mar 2026 16:50:25 +0100
Subject: [PATCH v5 4/4] media: dw100: Merge dw100_device_run and
 dw100_start
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-sklug-v6-16-topic-dw100-v3-1-dev-v5-4-1a7e1f721b50@ideasonboard.com>
References: <20260304-sklug-v6-16-topic-dw100-v3-1-dev-v5-0-1a7e1f721b50@ideasonboard.com>
In-Reply-To: <20260304-sklug-v6-16-topic-dw100-v3-1-dev-v5-0-1a7e1f721b50@ideasonboard.com>
To: Xavier Roumegue <xavier.roumegue@oss.nxp.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Nicolas Dufresne <nicolas@ndufresne.ca>, 
 Stefan Klug <stefan.klug@ideasonboard.com>
X-Mailer: b4 0.14.2

The dw100_start() function is only called from dw100_device_run(). As
both functions are not too big, move the code directly into
dw100_device_run() and drop dw100_start() to improve readability.

This patch contains no functional changes.

Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>
Reviewed-by: Xavier Roumegue <xavier.roumegue@oss.nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Changes in v4:
- Collected tags

Changes in v3:
- Added this patch as proposed in the review of v1
---
 drivers/media/platform/nxp/dw100/dw100.c | 77 +++++++++++++++-----------------
 1 file changed, 35 insertions(+), 42 deletions(-)

diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
index 43c218fa31b47402120de3e74959d2d38a6c3453..06fa8d758083b47074b22b8edb42af63cd9127ae 100644
--- a/drivers/media/platform/nxp/dw100/dw100.c
+++ b/drivers/media/platform/nxp/dw100/dw100.c
@@ -1440,49 +1440,10 @@ static irqreturn_t dw100_irq_thread_fn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void dw100_start(struct dw100_ctx *ctx, struct vb2_v4l2_buffer *in_vb,
-			struct vb2_v4l2_buffer *out_vb)
-{
-	struct dw100_device *dw_dev = ctx->dw_dev;
-
-	out_vb->sequence =
-		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)->sequence++;
-	in_vb->sequence =
-		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)->sequence++;
-
-	dev_dbg(&ctx->dw_dev->pdev->dev,
-		"Starting queues %p->%p, sequence %u->%u\n",
-		v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-				V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE),
-		v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-				V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE),
-		in_vb->sequence, out_vb->sequence);
-
-	v4l2_m2m_buf_copy_metadata(in_vb, out_vb);
-
-	/* Now, let's deal with hardware ... */
-	dw100_hw_master_bus_disable(dw_dev);
-	dw100_hw_init_ctrl(dw_dev);
-	dw100_hw_set_pixel_boundary(dw_dev);
-	dw100_hw_set_src_crop(dw_dev, &ctx->q_data[DW100_QUEUE_SRC],
-			      &ctx->q_data[DW100_QUEUE_DST]);
-	dw100_hw_set_source(dw_dev, &ctx->q_data[DW100_QUEUE_SRC],
-			    &in_vb->vb2_buf);
-	dw100_hw_set_destination(dw_dev, &ctx->q_data[DW100_QUEUE_DST],
-				 ctx->q_data[DW100_QUEUE_SRC].fmt,
-				 &out_vb->vb2_buf);
-	dw100_hw_set_mapping(dw_dev, ctx->map_dma,
-			     ctx->map_width, ctx->map_height);
-	dw100_hw_enable_irq(dw_dev);
-	dw100_hw_dewarp_start(dw_dev);
-
-	/* Enable Bus */
-	dw100_hw_master_bus_enable(dw_dev);
-}
-
 static void dw100_device_run(void *priv)
 {
 	struct dw100_ctx *ctx = priv;
+	struct dw100_device *dw_dev = ctx->dw_dev;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 
 	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
@@ -1494,7 +1455,7 @@ static void dw100_device_run(void *priv)
 	if (src_buf->vb2_buf.req_obj.req)
 		dw100_update_mapping(ctx);
 	else if (ctx->user_map_is_dirty)
-		dev_warn_once(&ctx->dw_dev->pdev->dev,
+		dev_warn_once(&dw_dev->pdev->dev,
 			      "V4L2 requests are required to update the vertex map dynamically\n");
 
 	/*
@@ -1504,7 +1465,39 @@ static void dw100_device_run(void *priv)
 	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
 				   &ctx->hdl);
 
-	dw100_start(ctx, src_buf, dst_buf);
+	src_buf->sequence =
+		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)->sequence++;
+	dst_buf->sequence =
+		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)->sequence++;
+
+	dev_dbg(&dw_dev->pdev->dev,
+		"Starting queues %p->%p, sequence %u->%u\n",
+		v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+				V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE),
+		v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+				V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE),
+		src_buf->sequence, dst_buf->sequence);
+
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf);
+
+	/* Now, let's deal with hardware ... */
+	dw100_hw_master_bus_disable(dw_dev);
+	dw100_hw_init_ctrl(dw_dev);
+	dw100_hw_set_pixel_boundary(dw_dev);
+	dw100_hw_set_src_crop(dw_dev, &ctx->q_data[DW100_QUEUE_SRC],
+			      &ctx->q_data[DW100_QUEUE_DST]);
+	dw100_hw_set_source(dw_dev, &ctx->q_data[DW100_QUEUE_SRC],
+			    &src_buf->vb2_buf);
+	dw100_hw_set_destination(dw_dev, &ctx->q_data[DW100_QUEUE_DST],
+				 ctx->q_data[DW100_QUEUE_SRC].fmt,
+				 &dst_buf->vb2_buf);
+	dw100_hw_set_mapping(dw_dev, ctx->map_dma,
+			     ctx->map_width, ctx->map_height);
+	dw100_hw_enable_irq(dw_dev);
+	dw100_hw_dewarp_start(dw_dev);
+
+	/* Enable Bus */
+	dw100_hw_master_bus_enable(dw_dev);
 }
 
 static const struct v4l2_m2m_ops dw100_m2m_ops = {

-- 
2.51.0

