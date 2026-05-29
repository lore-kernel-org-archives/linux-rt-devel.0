Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689213F0AA7;
	Fri, 29 May 2026 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070485; cv=none; b=JiH/3XOz+t4T+b0i/5OOmK6lKgTEUl7sINaEiD3okZv3pvia4jOxutShMOQENc0wfBOjwRI2G3jbXU2b+o6MNEc5OMar36acug7Tuvgi3sEQP6+XR4Ogo9blRQRF4ysWpXUNizTf/2Acbygl9YomKYrJuO9o9MMROqHR73u7SRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070485; c=relaxed/simple;
	bh=UjW/Pe6UHITNsDHiL7eJTjKdrJKc/5acD4hO8gSh8e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwUTBSJ6pBQLzJ4Xie37alRDfbsh0hCNQ4mkcL8XEi4Z+PuGjzu/gQMQFbl4XSeb52QaGaQu/CuJvfHjzSIhSVp3zFuvfIwol0PhTKUcgmUES9eUmDiy8iLj6ulGfe4V5fqM6ZW0XRYh4fb16GMmKlei7YRtaIOxAPwToYf4I7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3QBQkZiW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GgoSB/eF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3QBQkZiW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GgoSB/eF"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780070481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbk0LhHU3FI6TwZ60a2NlsxM8sxLDgATpkmtk/XCjCc=;
	b=3QBQkZiWrZUR0d1OhlOregdwwb+MHKjNIFd74ioC4x4rlO6RatRWUMx46n1crVTnFZhP2i
	tx0CUtSQHMhtgkSZyBzOHm+LugfmM6ZsPnek8ttu1K8BuqCN8E4xWDob25swQU2On7EBcg
	4Y63OE29m3jv/Ao8lX0nRzg0vGDgunLLIRn8a+02/Ouaa1WIVjgBD4/RsMwGvYtPDlbGjK
	cbe30JyNoLpvXRT+WUgdHqWcn7PQ/tpIDVXOc4TR3eznXPhusnnxoCOdz8fU9o1yb/z7PV
	tWsB5FOOxjCltAyxIyV/FvNHEEGXXQidfsiop5nq0leAXr4grKRSBS1ShhNmPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780070481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbk0LhHU3FI6TwZ60a2NlsxM8sxLDgATpkmtk/XCjCc=;
	b=GgoSB/eF/C4HZQeFpznvzh1NLr0RSGn7iGoCwRGr6s23AO9OTBk2zKLry2CA2WT45m1Y5b
	YI1r/z2Z+eUpUNDA==
To: linux-rt-devel@lists.linux.dev,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/5] mailbox: imx: Move the RXDB part of the mailbox into the threaded handler
Date: Fri, 29 May 2026 18:01:05 +0200
Message-ID: <20260529-imx_mbox_rproc-v1-3-b8ffc36e11e5@linutronix.de>
In-Reply-To: <20260529-imx_mbox_rproc-v1-0-b8ffc36e11e5@linutronix.de>
References: <20260529-imx_mbox_rproc-v1-0-b8ffc36e11e5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Move RXDB callback handling into the threaded handler. This similar to
the RX side except that we unmask it unconditionally in threaded
handler.

Move RXDB callback handling into the threaded handler.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mailbox/imx-mailbox.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 30a52c609e56b..9bf6484af45ed 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -528,6 +528,12 @@ static irqreturn_t imx_mu_isr_th(int irq, void *p)
 			imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->type, cp->=
idx), 0);
 		return IRQ_HANDLED;
=20
+	case IMX_MU_TYPE_RXDB:
+		cp->pending =3D 0;
+		priv->dcfg->rxdb(priv, cp);
+		imx_mu_xcr_rmw(priv, IMX_MU_GIER, IMX_MU_xCR_RIEn(priv->dcfg->type, cp->=
idx), 0);
+		return IRQ_HANDLED;
+
 	default:
 		dev_warn_ratelimited(priv->dev, "Unhandled channel type %d\n",
 				     cp->type);
@@ -585,7 +591,9 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		ret =3D IRQ_WAKE_THREAD;
 	} else if ((val =3D=3D IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx)) &&
 		   (cp->type =3D=3D IMX_MU_TYPE_RXDB)) {
-		priv->dcfg->rxdb(priv, cp);
+		cp->pending =3D 1;
+		imx_mu_xcr_rmw(priv, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(priv->dcfg->type, c=
p->idx));
+		ret =3D IRQ_WAKE_THREAD;
 	} else {
 		dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
 		return IRQ_NONE;

--=20
2.53.0

