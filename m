Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE93876BA
	for <linux-rt-devel@lists.linux.dev>; Thu, 29 Jan 2026 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687007; cv=none; b=XSOKcxpPkiOXK3wJziBgNeT/y3b+qa1E5ZiYQk950/ghGiZXSeJzG5zjb/+yYXUwguOA1kjpqoeOVrQvCvDP/KpvlCTJYkdMmoKyx31tHnCLwXJkIRfj4HiWRetJv3TL9UtRXYHGvXpSHZklWAwjlv25sW/X+s3Y+0SjhZ5lXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687007; c=relaxed/simple;
	bh=+Vp+WqODTAaIKelMntc3l329Z299faZuEWgOPeC848I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtRTfQCA6FjHV+T8Or03ZA0TKXgpgcWuc+xRciAtypLxIFgjKdg1HnySpCMix5j/fscfyishctwfXn0xOY6oWOSNYxpyqW6qr5uJcCgB0K3Ck0XWBBDiu5uWhFghtvnGgP4/j0etXzevuW0iHjl8Zprd8nnK2QiIElrW9Ck/0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OZjoCjCV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OZjoCjCV"
Received: from ideasonboard.com (unknown [IPv6:2a00:6020:448c:6c00:f52e:2bba:80e9:14d8])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 28C1E281C;
	Thu, 29 Jan 2026 12:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769686967;
	bh=+Vp+WqODTAaIKelMntc3l329Z299faZuEWgOPeC848I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OZjoCjCVnaZUBGKrrFlZvtp2TcFPMjZvvIOTQx3pCpeapD4I6rNRM23WTR2rE3gnY
	 pRnamynHmOq0xDT8VZ8khVHzSytDQG7wzfNZ3ofpSIYV6p9uFg4BoWwO2/N3oLEar+
	 BuzIXJQ3IBgcRCVhH0+iU9sSQ1JRB+Jxm4Zqjw8A=
From: Stefan Klug <stefan.klug@ideasonboard.com>
Date: Thu, 29 Jan 2026 12:43:13 +0100
Subject: [PATCH v3 4/4] media: dw100: Merge dw100_device_run and
 dw100_start
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-4-2eb5685eaf09@ideasonboard.com>
References: <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-0-2eb5685eaf09@ideasonboard.com>
In-Reply-To: <20260129-sklug-v6-16-topic-dw100-v3-1-dev-v3-0-2eb5685eaf09@ideasonboard.com>
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

---

Changes in v3:
- Added this patch as proposed in the review of v1
---
 drivers/media/platform/nxp/dw100/dw100.c | 61 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
index 46e3a7b74fb777aa479110a52229f36b8632db44..c7c4249f5769467fb2b1f3c87f5685c4463a0a9d 100644
--- a/drivers/media/platform/nxp/dw100/dw100.c
+++ b/drivers/media/platform/nxp/dw100/dw100.c
@@ -1442,25 +1442,42 @@ static irqreturn_t dw100_irq_thread_fn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void dw100_start(struct dw100_ctx *ctx, struct vb2_v4l2_buffer *in_vb,
-			struct vb2_v4l2_buffer *out_vb)
+static void dw100_device_run(void *priv)
 {
+	struct dw100_ctx *ctx = priv;
 	struct dw100_device *dw_dev = ctx->dw_dev;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 
-	out_vb->sequence =
-		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)->sequence++;
-	in_vb->sequence =
+	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+
+	v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
+				&ctx->hdl);
+
+	if (src_buf->vb2_buf.req_obj.req)
+		dw100_update_mapping(ctx);
+	else if (ctx->user_map_is_dirty)
+		dev_warn_once(&dw_dev->pdev->dev,
+			      "V4L2 requests are required to update the vertex map dynamically"
+		);
+
+	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
+				   &ctx->hdl);
+
+	src_buf->sequence =
 		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)->sequence++;
+	dst_buf->sequence =
+		dw100_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)->sequence++;
 
-	dev_dbg(&ctx->dw_dev->pdev->dev,
+	dev_dbg(&dw_dev->pdev->dev,
 		"Starting queues %p->%p, sequence %u->%u\n",
 		v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
 				V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE),
 		v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
 				V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE),
-		in_vb->sequence, out_vb->sequence);
+		src_buf->sequence, dst_buf->sequence);
 
-	v4l2_m2m_buf_copy_metadata(in_vb, out_vb);
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf);
 
 	/* Now, let's deal with hardware ... */
 	dw100_hw_master_bus_disable(dw_dev);
@@ -1469,10 +1486,10 @@ static void dw100_start(struct dw100_ctx *ctx, struct vb2_v4l2_buffer *in_vb,
 	dw100_hw_set_src_crop(dw_dev, &ctx->q_data[DW100_QUEUE_SRC],
 			      &ctx->q_data[DW100_QUEUE_DST]);
 	dw100_hw_set_source(dw_dev, &ctx->q_data[DW100_QUEUE_SRC],
-			    &in_vb->vb2_buf);
+			    &src_buf->vb2_buf);
 	dw100_hw_set_destination(dw_dev, &ctx->q_data[DW100_QUEUE_DST],
 				 ctx->q_data[DW100_QUEUE_SRC].fmt,
-				 &out_vb->vb2_buf);
+				 &dst_buf->vb2_buf);
 	dw100_hw_set_mapping(dw_dev, ctx->map_dma,
 			     ctx->map_width, ctx->map_height);
 	dw100_hw_enable_irq(dw_dev);
@@ -1482,30 +1499,6 @@ static void dw100_start(struct dw100_ctx *ctx, struct vb2_v4l2_buffer *in_vb,
 	dw100_hw_master_bus_enable(dw_dev);
 }
 
-static void dw100_device_run(void *priv)
-{
-	struct dw100_ctx *ctx = priv;
-	struct vb2_v4l2_buffer *src_buf, *dst_buf;
-
-	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
-	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
-
-	v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
-				&ctx->hdl);
-
-	if (src_buf->vb2_buf.req_obj.req)
-		dw100_update_mapping(ctx);
-	else if (ctx->user_map_is_dirty)
-		dev_warn_once(&ctx->dw_dev->pdev->dev,
-			      "V4L2 requests are required to update the vertex map dynamically"
-		);
-
-	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
-				   &ctx->hdl);
-
-	dw100_start(ctx, src_buf, dst_buf);
-}
-
 static const struct v4l2_m2m_ops dw100_m2m_ops = {
 	.device_run	= dw100_device_run,
 };

-- 
2.51.0

