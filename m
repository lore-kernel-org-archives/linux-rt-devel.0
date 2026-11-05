Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912037;
	b=c2ceTNy70MYRxu2PFSTA17UFpPmLqwtjXYbEw8dpc6KWy/TXPi+CwWYmRFx36dnfocqo
	 Qo/iutDzaW6d07jJdQkMHR3ndYHkrCLhdToNxgAmPP9ZrdjR87wp/nOyBtxeO/CvS2aPV
	 VWTczu7B4FzBe2hOkEXK1SU1raLxFrEMh6moRD5k4AhcAcUd8NOsK3n6ynOhZzl6qWNAZ
	 f2scHcbunPHLgU6+T0EhGpU/dUYcq4aR5ck3D/iSBhZie12QLp0MAwbibi/L4uAi7hLlr
	 ywApgSMrn3u+ZhyinbWFqRS4lU1e3kUVX6swPFmJ02MYpb+K7seSNFTjH6GM0789XnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3P4RqLHTtI+N7NRPxx7L4oSk93jGkzaKCLskeDcODf0=;
	b=WWduWR+4aRM8nyvXBjBmJiGmh75yD12itajv+LlwN8qXIXOmJ6l8kpvdIbRZ29d2iAh/
	 WBjLamiIbD5y4eJhyh5giQGJrbnB1pdqO1XtcLf1H9ACxzi+NWRjd8XQBfXTsAVV1a8Gx
	 4KdzzxVHeGBTj/f/JK9RhR5JaeCxoFANA3ErqPVJqZY0HMbO+km6SjVmnRjoRr6o8Jorh
	 J0SxkhooT+xMA/GvK9RrT4toZ2f58PfxwuDcqu67BOtrx7wsmWEM+6YBsJm0M9+Te75E+
	 Bna50R8voO7gZQIqii46z1SA1xczuih1GGqAgf7SvwJg6W3qum80stB8dhXnHBog+mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KdLsuCYD;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28702606A329
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 20:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28702606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KdLsuCYD
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so3808218a12.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 12:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793912035; x=1794516835; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3P4RqLHTtI+N7NRPxx7L4oSk93jGkzaKCLskeDcODf0=;
        b=KdLsuCYD9HKqk3tyY9vZrKHYZFZjnu2DlSJAuuGA4GqBfbx+KbJ4AJcVVz0PFJiRcD
         flkFPW7d3zcxnB50n6VaZCFoFNYrmlp0by/NNcaVMTMz+01xECWuiwAiVAp1zRQr6j9D
         BB5DIeC94oAl+hgWBLUrK4lXCV2dSo9QKQX+9e01k13MWhPIPjcSiYhRz9K89cxHkeei
         rN2zf59TNHwCQFyXdl3NDykeQD1Iqrn4GVkqjkHNT/7rT5S7mIMdQ4HhMBHxsW0v+lKo
         foikJEMMM/tytstBlpDTcyiIFuCRm5cf6oeJzxySgMONiOJ1OxNuk3WkMV4pvn7J4s0O
         vTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912035; x=1794516835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3P4RqLHTtI+N7NRPxx7L4oSk93jGkzaKCLskeDcODf0=;
        b=nGGa1dWbEu24a8okO2plg3dk386RTKIeeE8fUfRNCYYJtVDfvResn+G0gVAn9oF86O
         ElslUBfIzqDBpdOd7xhRCBqpUc2lOmtACSz70KzLqLT6WayXZCs1WXMBVdzvHeaycm++
         I7TU5adlOBqi97W8SYXGN3Zq+lTgvwX1mXE9LncV5JwrDBDbwNrfCvriH+dqptovr5Cz
         aCNEuiR4igHrTlam/Iulr7Jsf/in3FKtBFt89YBhc5WKWgl1lBaOCtbcnR0DGallW1x5
         9jcSnQJrhxX1sDhPZ84NIeDzbKyD2uf8TKT6ZuKuBnFmLrvFJB9CKJ+8itr+QBMWbAfd
         sa3w==
X-Forwarded-Encrypted: i=1; AKwUvByj+qIXJhfTFdn+FtvPk/mVEcYFpkOefgZ/y9LE5qBReAHtMrVPDDepkL+tp+T/9Fjq+30buz0BiYSG6tRKuw==@lists.linux.dev
X-Gm-Message-State: APuU4Z93aBaRy2mj1PNftJyAmo6YJA/jyK3ZINQSyTUTxL1CmbSwf/xk
	29VjBeldA9ICTqRCtlw0WLbPGQuJrcF+oovOMz0P0/0gL732lWm3E3Uz
X-Gm-Gg: AYBFou2UYHWP5l7mk4uG1QVf9f+hLT22r9BuZJFZA9eHK42TcCytI7a4JHT6PEsuKdw
	57ydzEEdAMK8WNsY75yjJelnfpDqzXSnpHGdnRpyKf74hbu5ZxTkJD3n1wF7icwUV1ahvQwf5c3
	7FX1nZVoxDur/YdCKiorhVMtqACh5Ex8D6nbRvEqTGX96RrzFZ/6oIFQjoA+CdNRwHMYBFqJ2JT
	SVdjw1T0QX0tWDyEGY7aPBOkgJEchR8sqc+zJpJVol7vdvJnJfpvd4M5z+EcS6aZmPHCStySbvp
	BBQ1SyPdwVRKm6feAlNv/3NIUIkDU50Vabi23CVSJNZY2ThYtLIdq3s5xHY0TvbjIgAfiHbVgkT
	7A5KoLwaow8eKHDwb4a+G8wUl/oaVe4YuLlKU3MFVyM6V0NtKZdfcnMq1WZKz5OWQmghmle6tyg
	TOP8Fe2nawYs2XZVDkcbDtCiPGL0TXQlArakchQ+/0oEQGHMBRqJ84YYJj2SoY9BgKwD8YJt8rw
	tyFfWcZvMqP71xvGpHQQgEnexE6t6bwoA81SFuwQybx3Iqdz4N4fML4f7rZ666PiU5dCaKEL6uj
	0TtFLIxVW7B0svYEyRKkG10P1Ao6vk2JboN3uqOWkd/u6v2wqIfX9P92090vq/77n6Iv5bmJzAF
	NTRC8wMD1s7Vd7bL+AqC0VYf2Z+dgstJTDY+xA2H6ZuxOyaT6HgWBOdDFfOVeH6EC8J5+IyduIN
	+ucrUVJd6hy/cvaQI6Um2lCopWi3J4O7LprHDFB0DZ3lOFGOIdM7DSpkIG1+bfznSVHmsCR9hAh
	FgkI6+qcyFfqCY=
X-Received: by 2002:a05:6402:449b:b0:6b5:e088:eb79 with SMTP id 4fb4d7f45d1cf-6b5e088edd8mr40510a12.14.1793912035306;
        Thu, 05 Nov 2026 12:53:55 -0800 (PST)
Received: from mb-HP-ZBook-Power-16-inch-G11-Mobile-Workstation-PC.dynamic.ziggo.nl (2001-1c00-1106-0900-938c-4ed8-a3bb-093f.cable.dynamic.v6.ziggo.nl. [2001:1c00:1106:900:938c:4ed8:a3bb:93f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b576406e13sm1234072a12.19.2026.11.05.12.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:53:54 -0800 (PST)
From: Mario Behn <mario.behn@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mario Behn <mario.behn@gmail.com>
Subject: [PATCH] usb: chipidea: udc: give up when the endpoint halt bit is not taken
Date: Thu,  5 Nov 2026 21:53:42 +0100
Message-ID: <20261105205343.982465-1-mario.behn@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hw_ep_set_halt() writes the stall bit of an endpoint and loops until it
reads back. On endpoint 0 the controller clears the stall bit itself when
a SETUP packet arrives, so when one arrives while the driver stalls the
endpoint the loop never ends. It runs in the UDC interrupt thread with the
controller lock held, and the SETUP packet it is waiting out can only be
consumed by that same thread.

Seen on a Zynq-7000 (an ADALM-PLUTO class board, PREEMPT_RT) during the
host RNDIS initialisation: the gadget stalls the GET_ENCAPSULATED_RESPONSE
poll that has no answer yet, the stall is refused, the interrupt thread
spins for a minute, RCU stalls and every other USB operation blocks on the
lock. With a bounded loop the condition shows on 1 to 3 percent of boots
and is harmless: the pending SETUP packet is handled next and the host
repeats its poll.

Retry for about a millisecond, then warn with the endpoint control and
setup status registers and return -EBUSY. The callers already report a
failed stall.

A loop timeout for the same hang was proposed in 2021 (usb: chipidea: add
loop timeout for hw_ep_set_halt(), Jeaho Hwang) and not applied.

Signed-off-by: Mario Behn <mario.behn@gmail.com>
---
 drivers/usb/chipidea/udc.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index d52f89489893..4f4e6d296de5 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -224,20 +224,28 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
  */
 static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
 {
+	enum ci_hw_regs reg = OP_ENDPTCTRL + num;
+	u32 mask_xs = (dir == TX) ? ENDPTCTRL_TXS : ENDPTCTRL_RXS;
+	u32 mask_xr = (dir == TX) ? ENDPTCTRL_TXR : ENDPTCTRL_RXR;
+	int retries = 1000;
+
 	if (value != 0 && value != 1)
 		return -EINVAL;
 
 	do {
-		enum ci_hw_regs reg = OP_ENDPTCTRL + num;
-		u32 mask_xs = (dir == TX) ? ENDPTCTRL_TXS : ENDPTCTRL_RXS;
-		u32 mask_xr = (dir == TX) ? ENDPTCTRL_TXR : ENDPTCTRL_RXR;
-
 		/* data toggle - reserved for EP0 but it's in ESS */
 		hw_write(ci, reg, mask_xs|mask_xr,
 			  value ? mask_xs : mask_xr);
-	} while (value != hw_ep_get_halt(ci, num, dir));
-
-	return 0;
+		if (value == hw_ep_get_halt(ci, num, dir))
+			return 0;
+		udelay(1);
+	} while (--retries);
+
+	dev_warn_ratelimited(ci->dev,
+			     "ep%d%s: halt=%d not taken, ENDPTCTRL 0x%08x ENDPTSETUPSTAT 0x%08x\n",
+			     num, dir == TX ? "in" : "out", value, hw_read(ci, reg, ~0),
+			     hw_read(ci, OP_ENDPTSETUPSTAT, ~0));
+	return -EBUSY;
 }
 
 /**
-- 
2.53.0

