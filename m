Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5010388396
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738590; cv=none; b=pxW+DDWnhVQe+Dw1pGhty/KlrMGqvb7w2CZonmnCKN2GgZM/lEMauMghQnV3KXm7QdcqEc2KDfUWxlw1jjh2IIprqVzP091usQrr5c0e3q+dYGF60h6GUggDIh0pmqkzZvcpLqo26r+KSfabBOc+OqH9GF8JcQXMB5EUWkcU9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738590; c=relaxed/simple;
	bh=8FsckFIh/hQkogKq/cihPf0hnOfUQi6qvPh7dz/ckjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwjqVAZYXEA4tLhXbtcQaRVfC4hmiwxwZVkSZfQ9qWtZTKaHoHObfJ3Yc9ut/exSdf5vtP9OBTF5WlOsKZmVe6/wDA9VVmctDMD1Olz+mIu416SjU0hL/phcbyJstTdqIKLcBIjhTEBqgH2i5+i7kbFeaoPfVm4rfbOM98ixQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=DLk6XBAG; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="DLk6XBAG"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f7020a928eso14361119eec.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1779738588; x=1780343388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb3DZIwxIy7De4Nzc/EChnZm9vuGaoBDU44qBc/YnTE=;
        b=DLk6XBAGnyKtvDrCf+m4CJ3Q1yUBS1neP3HsEn7L5QwN37PPW5Ij5OvDrP7YQVdH+0
         8WGF36f2uw033SO+CkZpJvZdwyYJ3WWPspilyrtqzC5eIoWaGekeMDF+C0Y3PXgiijP7
         cfFSRlS1bFhPRN0CNz/gpj2fDgPnurXuIgkU/NAALR5+1zLS2OXaXkfhcruenyuwA7WV
         nJDTzTU+izhRS12JiVbZ7ba5IBISUhiDOB9P04vj3u4lgzVypKfP4tPGJklYmvvk25+2
         EI/AhuYMeV/t4e2Nfe+Odi6Fe53RZI9bd3mk0T+lebtpC4TY2D/TQJDL06mNeOiaFys7
         WMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738588; x=1780343388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pb3DZIwxIy7De4Nzc/EChnZm9vuGaoBDU44qBc/YnTE=;
        b=KlJJWn60kbDLBewc7+BWFbnUg1df9RTed2OKg+KooR1Rt56Wfx9SPgkPKntAm+X7BC
         mmvWqxW+Lkwx6xN23DxjFzQwmGJ0xH+GMXmqhtHgnik4/Yv3pkIH7JD6Oji3R4fB5IJJ
         yFyLy6xThLflr8FB44V7sVUwjZ1ibarssraoN3+vzqXV5maX7j5BVeVrLyE22/xYWkT6
         DoNyqQ8IJYNheCeQ1Sv+3A1HUYsCv/NHKQIXO+XtEu/NIkZFyBrn3a52kGKL4Nut0b5n
         tHX+ty8hm+dWWbQDiSFnEWn4P5VhITRkHR0YMDQVnQZMfUqOzjOPc8w5T/fivIcdQlKv
         QA3A==
X-Forwarded-Encrypted: i=1; AFNElJ+8ZUmEB+WQ1bLjLQvAJSeVKh4TTDWL1KPjc9r/2ruPhcsmCv5TrpjU8VYFHjzyVG3yCpiJUT8UDBmbkqQKrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywoh5G9Cdp2yHLhUPi1bkO8O04YMg5g2m4MbtZJRIC/ZH//CqD7
	3lECphmtEOAnGRkrqjC3vU4Qq6w7o+GBtdbqOXRefyJcocf8Pew1vCIx331mbHQlRiQ=
X-Gm-Gg: Acq92OEB/Efb5rCAG47aenqYa97gah+p4J/QLxAmltytA+ELI01btyu3emdha375JjB
	3EAtG90DQn3VYul5/p5eypTZSAodo6DMzkyCLlGlL+sAXR9b23aFhHXxeX5I0sijLvpFZOfMQd9
	LnHmViUeDtu47B1LkGgm6iWQWPvDzRNwi1WtVCV+bwXoirmVjQYlQ6po48VOTElrq4/k9pXyX6k
	Z+uszVEA6WPR+mBxy8xAiAeYKYUijMA9dwDgnXDvbfPCTC1zne0HRnqSmteTV2V9bGe2IetygAN
	dZ4KMvCbxutVoDaLhf1YJ1OxseXTAH2SK0qnoy0LVpFKPNWdwFfEZjx558MljSdD3KwDazE8fAm
	ij9TlvpZbJWXxNZjawdRJBE0988PGepgQYl4I8Lyyct/9yqer7nVhzSWgOG9DwI92/21dGiyTxi
	AampZSmlITH/9vAH88rXFxWLpUjFKIpWju6p3S
X-Received: by 2002:a05:7300:df49:b0:304:9b48:53da with SMTP id 5a478bee46e88-3049b4857dbmr960345eec.26.1779738587878;
        Mon, 25 May 2026 12:49:47 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:2feb:307b:ed4b:5f1d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230dddsm11032141eec.17.2026.05.25.12.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:49:47 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Byczkowski <by@by-online.de>,
	Eliav Farber <farbere@amazon.com>,
	linux-rt-devel@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v6 2/3] pps: kc: convert pps_kc_hardpps_lock to raw_spinlock_t
Date: Mon, 25 May 2026 12:49:31 -0700
Message-ID: <e39cc17ed9652278057a3ddfbded3979dc45719e.1779733602.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779733602.git.calvin@wbinvd.org>
References: <cover.1779733602.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Byczkowski <by@by-online.de>

pps_kc_hardpps_lock is held in pps_kc_event(), which calls
hardpps(). hardpps() takes tk_core.lock, which is already a
raw_spinlock_t -- and nesting a sleeping lock (PREEMPT_RT's
spinlock_t) over a raw_spinlock_t is invalid.

Convert pps_kc_hardpps_lock and its call sites in kc.c to
raw_spinlock_t to make the nesting valid on PREEMPT_RT.

While here, refactor pps_kc_bind() and pps_kc_remove() to use
guard(raw_spinlock_irq) for scope-based lock release. This
eliminates four duplicated unlock call sites in pps_kc_bind()
and the ambiguous bracket structure that resulted from them.
Behavior is unchanged.

No functional change on non-RT kernels.

Tested-by: Michael Byczkowski <by@by-online.de>
Tested-by: Calvin Owens <calvin@wbinvd.org>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Michael Byczkowski <by@by-online.de>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/pps/kc.c | 67 ++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/pps/kc.c b/drivers/pps/kc.c
index fbd23295afd7..715b775e9679 100644
--- a/drivers/pps/kc.c
+++ b/drivers/pps/kc.c
@@ -21,7 +21,7 @@
  */
 
 /* state variables to bind kernel consumer */
-static DEFINE_SPINLOCK(pps_kc_hardpps_lock);
+static DEFINE_RAW_SPINLOCK(pps_kc_hardpps_lock);
 /* PPS API (RFC 2783): current source and mode for kernel consumer */
 static struct pps_device *pps_kc_hardpps_dev;	/* unique pointer to device */
 static int pps_kc_hardpps_mode;		/* mode bits for kernel consumer */
@@ -36,35 +36,31 @@ static int pps_kc_hardpps_mode;		/* mode bits for kernel consumer */
 int pps_kc_bind(struct pps_device *pps, struct pps_bind_args *bind_args)
 {
 	/* Check if another consumer is already bound */
-	spin_lock_irq(&pps_kc_hardpps_lock);
+	guard(raw_spinlock_irq)(&pps_kc_hardpps_lock);
 
-	if (bind_args->edge == 0)
-		if (pps_kc_hardpps_dev == pps) {
-			pps_kc_hardpps_mode = 0;
-			pps_kc_hardpps_dev = NULL;
-			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_info(&pps->dev, "unbound kernel"
-					" consumer\n");
-		} else {
-			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_err(&pps->dev, "selected kernel consumer"
-					" is not bound\n");
+	if (bind_args->edge == 0) {
+		/* Unbind request */
+		if (pps_kc_hardpps_dev != pps) {
+			dev_err(&pps->dev,
+				"selected kernel consumer is not bound\n");
 			return -EINVAL;
 		}
-	else
-		if (pps_kc_hardpps_dev == NULL ||
-				pps_kc_hardpps_dev == pps) {
-			pps_kc_hardpps_mode = bind_args->edge;
-			pps_kc_hardpps_dev = pps;
-			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_info(&pps->dev, "bound kernel consumer: "
-				"edge=0x%x\n", bind_args->edge);
-		} else {
-			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_err(&pps->dev, "another kernel consumer"
-					" is already bound\n");
+		pps_kc_hardpps_mode = 0;
+		pps_kc_hardpps_dev = NULL;
+		dev_info(&pps->dev, "unbound kernel consumer\n");
+	} else {
+		/* Bind request */
+		if (pps_kc_hardpps_dev && pps_kc_hardpps_dev != pps) {
+			dev_err(&pps->dev,
+				"another kernel consumer is already bound\n");
 			return -EINVAL;
 		}
+		pps_kc_hardpps_mode = bind_args->edge;
+		pps_kc_hardpps_dev = pps;
+		dev_info(&pps->dev,
+			 "bound kernel consumer: edge=0x%x\n",
+			 bind_args->edge);
+	}
 
 	return 0;
 }
@@ -78,15 +74,14 @@ int pps_kc_bind(struct pps_device *pps, struct pps_bind_args *bind_args)
  */
 void pps_kc_remove(struct pps_device *pps)
 {
-	spin_lock_irq(&pps_kc_hardpps_lock);
-	if (pps == pps_kc_hardpps_dev) {
-		pps_kc_hardpps_mode = 0;
-		pps_kc_hardpps_dev = NULL;
-		spin_unlock_irq(&pps_kc_hardpps_lock);
-		dev_info(&pps->dev, "unbound kernel consumer"
-				" on device removal\n");
-	} else
-		spin_unlock_irq(&pps_kc_hardpps_lock);
+	guard(raw_spinlock_irq)(&pps_kc_hardpps_lock);
+
+	if (pps != pps_kc_hardpps_dev)
+		return;
+
+	pps_kc_hardpps_mode = 0;
+	pps_kc_hardpps_dev = NULL;
+	dev_info(&pps->dev, "unbound kernel consumer on device removal\n");
 }
 
 /* pps_kc_event - call hardpps() on PPS event
@@ -102,8 +97,8 @@ void pps_kc_event(struct pps_device *pps, struct pps_event_time *ts,
 	unsigned long flags;
 
 	/* Pass some events to kernel consumer if activated */
-	spin_lock_irqsave(&pps_kc_hardpps_lock, flags);
+	raw_spin_lock_irqsave(&pps_kc_hardpps_lock, flags);
 	if (pps == pps_kc_hardpps_dev && event & pps_kc_hardpps_mode)
 		hardpps(&ts->ts_real, &ts->ts_raw);
-	spin_unlock_irqrestore(&pps_kc_hardpps_lock, flags);
+	raw_spin_unlock_irqrestore(&pps_kc_hardpps_lock, flags);
 }
-- 
2.47.3

