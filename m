Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF33D7D9E
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034660; cv=none; b=CYH0VuBedJVyAuUqe/8sPE9jdXWhz0msBMNQyjGKj7/18Dxl7yfGUSv8CrhfxMu5hUO5dwo9TLzg9hUx+aoldpYfd9d+sph+v5gjRq41cJTv0ESxw+8QspzL2rw36H1qZr2mLqwmi/ABEmASOl92cyXYuwkVbpmpCWSSOGn8O/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034660; c=relaxed/simple;
	bh=OoG/1K9A8qjXykeY48UsilyxIkViXFpGFJO8t9YtmLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrM9wN1iHmkNfEz4qiwMZCDKWiehxQKZfEwjQSCPWy+GKUeaOCeCT0UY1hMm79oq/VYqt9HTmuEefBa0Q5fC42paP3fS0JCb9nj3/cDfRDLKxfpKNDUwdaxf8aDso2FOcDErtm97oj1+JIFo8ZUW04rxnY1/8f3JMtJSDzHbfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=shP7c0sV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="shP7c0sV"
Received: from ideasonboard.com (unknown [IPv6:2a00:6020:448c:6c00:cd05:b041:1dc3:f62c])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 96F94121A;
	Wed, 25 Feb 2026 16:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1772034598;
	bh=OoG/1K9A8qjXykeY48UsilyxIkViXFpGFJO8t9YtmLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=shP7c0sVVi7zA8isn2bG8vmDyAnczDGsPxuABYKS7ByuDhHerIYhDz7MDMA2zjLCc
	 shtGvFjDMgStmojxH+7q8knT9F5SZx0l6OaJuE+/s37kpkt/9IBE/4MWCJq4vhfu0t
	 ygYvzAbxCC0bKtGYpbJNdVwWPLeU5D6i4g3olGLE=
From: Stefan Klug <stefan.klug@ideasonboard.com>
Date: Wed, 25 Feb 2026 16:50:48 +0100
Subject: [PATCH v4 2/4] media: dw100: Implement dynamic vertex map update
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-sklug-v6-16-topic-dw100-v3-1-dev-v4-2-53536d08de91@ideasonboard.com>
References: <20260225-sklug-v6-16-topic-dw100-v3-1-dev-v4-0-53536d08de91@ideasonboard.com>
In-Reply-To: <20260225-sklug-v6-16-topic-dw100-v3-1-dev-v4-0-53536d08de91@ideasonboard.com>
To: Xavier Roumegue <xavier.roumegue@oss.nxp.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Nicolas Dufresne <nicolas@ndufresne.ca>, 
 Stefan Klug <stefan.klug@ideasonboard.com>
X-Mailer: b4 0.14.2

Implement dynamic vertex map updates by handling the
V4L2_CID_DW100_DEWARPING_16x16_VERTEX_MAP control during streaming. This
allows to implement features like dynamic zoom, pan, rotate and dewarp.

To stay compatible with the old version, updates of
V4L2_CID_DW100_DEWARPING_16x16_VERTEX_MAP are ignored during streaming
when requests are not used. Print a corresponding warning once.

Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Changes in v4:
- Added missing newline at end of warning message
- Fixed position of closing parenthesis
- Collected tag

Changes in v2:
- Replaced the manual warn once by dev_warn_once(). This changes the
  frequency from once per context to once per boot which was agreed to
  be enough.
- Renamed user_map_needs_update to user_map_is_dirty as it is more
  expressive and fits to user_map_is_set
- Fixed indentation issue found by Media CI
---
 drivers/media/platform/nxp/dw100/dw100.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
index e05a65e0122a2584992aefd1b8fc70ce64e86bfb..2d5c3199428dfa38d1bb253923863b8137a8bea4 100644
--- a/drivers/media/platform/nxp/dw100/dw100.c
+++ b/drivers/media/platform/nxp/dw100/dw100.c
@@ -98,6 +98,7 @@ struct dw100_ctx {
 	unsigned int			map_width;
 	unsigned int			map_height;
 	bool				user_map_is_set;
+	bool				user_map_is_dirty;
 
 	/* Source and destination queue data */
 	struct dw100_q_data		q_data[2];
@@ -293,11 +294,15 @@ static u32 dw100_map_format_coordinates(u16 xq, u16 yq)
 	return (u32)((yq << 16) | xq);
 }
 
-static u32 *dw100_get_user_map(struct dw100_ctx *ctx)
+static void dw100_update_mapping(struct dw100_ctx *ctx)
 {
 	struct v4l2_ctrl *ctrl = ctx->ctrls[DW100_CTRL_DEWARPING_MAP];
 
-	return ctrl->p_cur.p_u32;
+	if (!ctx->user_map_is_dirty)
+		return;
+
+	memcpy(ctx->map, ctrl->p_cur.p_u32, ctx->map_size);
+	ctx->user_map_is_dirty = false;
 }
 
 /*
@@ -306,8 +311,6 @@ static u32 *dw100_get_user_map(struct dw100_ctx *ctx)
  */
 static int dw100_create_mapping(struct dw100_ctx *ctx)
 {
-	u32 *user_map;
-
 	if (ctx->map)
 		dma_free_coherent(&ctx->dw_dev->pdev->dev, ctx->map_size,
 				  ctx->map, ctx->map_dma);
@@ -318,8 +321,8 @@ static int dw100_create_mapping(struct dw100_ctx *ctx)
 	if (!ctx->map)
 		return -ENOMEM;
 
-	user_map = dw100_get_user_map(ctx);
-	memcpy(ctx->map, user_map, ctx->map_size);
+	ctx->user_map_is_dirty = true;
+	dw100_update_mapping(ctx);
 
 	dev_dbg(&ctx->dw_dev->pdev->dev,
 		"%ux%u %s mapping created (d:%pad-c:%p) for stream %ux%u->%ux%u\n",
@@ -351,6 +354,7 @@ static int dw100_s_ctrl(struct v4l2_ctrl *ctrl)
 	switch (ctrl->id) {
 	case V4L2_CID_DW100_DEWARPING_16x16_VERTEX_MAP:
 		ctx->user_map_is_set = true;
+		ctx->user_map_is_dirty = true;
 		break;
 	}
 
@@ -405,6 +409,7 @@ static void dw100_ctrl_dewarping_map_init(const struct v4l2_ctrl *ctrl,
 	}
 
 	ctx->user_map_is_set = false;
+	ctx->user_map_is_dirty = true;
 }
 
 static const struct v4l2_ctrl_type_ops dw100_ctrl_type_ops = {
@@ -1478,6 +1483,12 @@ static void dw100_device_run(void *priv)
 	v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
 				&ctx->hdl);
 
+	if (src_buf->vb2_buf.req_obj.req)
+		dw100_update_mapping(ctx);
+	else if (ctx->user_map_is_dirty)
+		dev_warn_once(&ctx->dw_dev->pdev->dev,
+			      "V4L2 requests are required to update the vertex map dynamically\n");
+
 	/*
 	 * As the hardware does not update any volatile controls, we can
 	 * complete control handling before starting the dewarper.

-- 
2.51.0

