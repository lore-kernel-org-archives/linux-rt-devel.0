Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A773939AE
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738592; cv=none; b=IjPGcM1iXpDxOiwef7WGA3NFn6JqGXPb4SDvZnMoeQwH7TcQgliuLdaiRJCckxQlSaH5/yaTLSZ3RJYeODjoix8+XK9mGJf6WBQ1IrJcvzxtec+YVgi39tLPRRZYXFFVKs0CP5Q2JZQiJ/TazKGw/mxq83Y12Lr6PIsNcXvYWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738592; c=relaxed/simple;
	bh=I8j2swgsdkC+/ibyO5t4yrHfPjhEcHCtqWfaWFfel7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvZfFMCq6si2mrqgz9aB1kiWsrtAh/lNIW1ntTioL8k8W1L+m/1y/KX6ZbhsKqy+X+BrXxXogqcIgYlmiMZSDjpwyAKE/7c7F3chx3YLwIRscHaROnHUP04PfQTeWbOGIbwLrLoityAxHVHmP1SRSHXCVen6tGAgFlHP6OEZuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=AoZxI5e8; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="AoZxI5e8"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f7020a928eso14361147eec.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1779738589; x=1780343389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTL+d3d84GaCTUSVSRN0Nbz2eetQdKxRxbxMPmywTIA=;
        b=AoZxI5e8RbU7ua+MBUWqnsvztFV5TMd5zIfy4a/Qxaf6PghERcGO3kjIEUKHDrs2vE
         joNBIR6lTrCchMIt7Y/9T0iTsjXxlfE2YNIoy2wH5l1EbZMgxYhdWNmFAbXNxVPC3FmC
         cHk+En5en9XXuwqB6KF+nxYQa66rVhTupz8eacSKO3r5WjH9IwzUJ0ELgaVXaAu4g0GY
         uXgQvOZZf/6kRUT/61I8Awz2IHhsEwfZgYr2SewRg0faiMCMFs7Xjtypf6npk41saNZC
         yYqzDp4Asq+xkTWKZwfvhMPTM/LZEg8LK0M0b8vtVJmP0WNaiOgLWlkVbjAe0mtsHghx
         ahcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738589; x=1780343389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xTL+d3d84GaCTUSVSRN0Nbz2eetQdKxRxbxMPmywTIA=;
        b=p8GyYY4tH+FmX8G3CyVGTVFm/fgy8uHADe1+XKU7exnYsFTekYMJMzYreFMTTYiQ8I
         JejWRKZ79aFtgm660TTQsMyvm1SZEe4Yjghh6zo9xhZnjPlTdXzn1Lz2f89WoMWpdyy3
         C5Ordz31mKvtildgQ7F4tVPHUC6DsOdCkD7g9ccZjwk5r7kw15T1jaAHR2T/AuGSTs6j
         GYML2RThX/S8gRddes8pJr6GuOY0Vn2TcUpcRVkrF1u00KlCF3K3X+H794u3idyxq3HF
         IKqf4T06RPa1tZGpmGed8JG8SJJYf8e9WJoiZO2Sf1vJvQ2/R9ajYcbf1wYp4O1OOV4c
         tjUw==
X-Forwarded-Encrypted: i=1; AFNElJ8aZfs7D6FWVWLTG2NsU38I3Ui+hV45O9Wou8oOT8+fdqIzmt/qS4Qw6uDi1ZMWSYf376abLPwo3SHmKEbwOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeKi1QpS/64gnX21rjspuoxf/0gMfvPRmZbDE6zda3j4ryqRAL
	0U2fPhHGvn4Y607KlFLJeLKkbCG3Lq6iQFexSZ5u+2Z3c49QxbSZeJcNCe8wZzjz0jY=
X-Gm-Gg: Acq92OF/vymv0bcTebsNeRjXkQa/eNDsv08Nmsij47YG8TAey97sA4m36E2KqWNAoUw
	ALQ+meRil17GKQZoDtv+f8o8xypoVUfnkQVV/xPbIJT3mfXdvDF82bVdGXSU88oHQt95Z3tPoAW
	Mxe7Stjw0itWFRDSSv//n56wsAZIRccyWNUBldV7KW2jAa2SmFHB/IWbKnVkSz2xEN6kkE2lKlZ
	SMJPT1Nd+jYGTwG9NPLW7fqxmm14q9PdDA9BnAIrFB/FCNeZFkgvNiqWnnLJvVrhkJtpYu08WvX
	BhWk+kFfDY5CSUZnjzw5452pVqBWZIXDFaUFxs1Vf7XZUpyR9VjJiG64lHdXtP0zE/PJ2m84/TV
	+GAnhQ8V8VbTcdIocazdf/9KSX5BMdhbgAJLS4JOEkXkEaC4W/sxPGP9Jx81XvvSxJFppTUbO7y
	KLVMhqBEka1fCSzw49hSdahFzW2Q==
X-Received: by 2002:a05:7301:2a24:b0:2de:aafb:feff with SMTP id 5a478bee46e88-3044904e1dbmr6826873eec.2.1779738589495;
        Mon, 25 May 2026 12:49:49 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:2feb:307b:ed4b:5f1d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230dddsm11032141eec.17.2026.05.25.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:49:49 -0700 (PDT)
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
Subject: [PATCH v6 3/3] pps: convert pps_device.lock to raw_spinlock_t
Date: Mon, 25 May 2026 12:49:32 -0700
Message-ID: <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
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

pps_device.lock is acquired from the PPS hardirq path
(pps_event() and friends). On PREEMPT_RT, spinlock_t becomes a
sleeping rt_mutex, so taking it in hardirq context produces
"BUG: scheduling while atomic" splats and breaks PPS event
delivery entirely.

Convert pps_device.lock to raw_spinlock_t, which remains a true
spinning lock on RT, and update all call sites in kapi.c and
pps.c to use raw_spin_lock_irqsave() / raw_spin_unlock_irqrestore()
(and the _irq variants where appropriate). The critical sections
are short and deterministic, so raw_spinlock_t semantics are
appropriate.

No functional change on non-RT kernels.

Tested-by: Michael Byczkowski <by@by-online.de>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Michael Byczkowski <by@by-online.de>
Tested-by: Calvin Owens <calvin@wbinvd.org>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/pps/kapi.c         |  6 +++---
 drivers/pps/pps.c          | 16 ++++++++--------
 include/linux/pps_kernel.h |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index 1bf0335a1b41..dc7fac75ec27 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -102,7 +102,7 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 		pps->info.echo = pps_echo_client_default;
 
 	init_waitqueue_head(&pps->queue);
-	spin_lock_init(&pps->lock);
+	raw_spin_lock_init(&pps->lock);
 
 	/* Create the char device */
 	err = pps_register_cdev(pps);
@@ -167,7 +167,7 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 
 	timespec_to_pps_ktime(&ts_real, ts->ts_real);
 
-	spin_lock_irqsave(&pps->lock, flags);
+	raw_spin_lock_irqsave(&pps->lock, flags);
 
 	/* Must call the echo function? */
 	if ((pps->params.mode & (PPS_ECHOASSERT | PPS_ECHOCLEAR)))
@@ -214,6 +214,6 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 		kill_fasync(&pps->async_queue, SIGIO, POLL_IN);
 	}
 
-	spin_unlock_irqrestore(&pps->lock, flags);
+	raw_spin_unlock_irqrestore(&pps->lock, flags);
 }
 EXPORT_SYMBOL(pps_event);
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index de1122bb69ea..75eb7973e37c 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -106,12 +106,12 @@ static long pps_cdev_ioctl(struct file *file,
 	case PPS_GETPARAMS:
 		dev_dbg(&pps->dev, "PPS_GETPARAMS\n");
 
-		spin_lock_irq(&pps->lock);
+		raw_spin_lock_irq(&pps->lock);
 
 		/* Get the current parameters */
 		params = pps->params;
 
-		spin_unlock_irq(&pps->lock);
+		raw_spin_unlock_irq(&pps->lock);
 
 		err = copy_to_user(uarg, &params, sizeof(struct pps_kparams));
 		if (err)
@@ -142,7 +142,7 @@ static long pps_cdev_ioctl(struct file *file,
 			return -EINVAL;
 		}
 
-		spin_lock_irq(&pps->lock);
+		raw_spin_lock_irq(&pps->lock);
 
 		/* Save the new parameters */
 		pps->params = params;
@@ -166,7 +166,7 @@ static long pps_cdev_ioctl(struct file *file,
 		pps->params.assert_off_tu.flags = 0;
 		pps->params.clear_off_tu.flags = 0;
 
-		spin_unlock_irq(&pps->lock);
+		raw_spin_unlock_irq(&pps->lock);
 
 		break;
 
@@ -193,7 +193,7 @@ static long pps_cdev_ioctl(struct file *file,
 			return err;
 
 		/* Return the fetched timestamp and save last fetched event  */
-		spin_lock_irq(&pps->lock);
+		raw_spin_lock_irq(&pps->lock);
 
 		pps->last_fetched_ev = pps->last_ev;
 
@@ -203,7 +203,7 @@ static long pps_cdev_ioctl(struct file *file,
 		fdata.info.clear_tu = pps->clear_tu;
 		fdata.info.current_mode = pps->current_mode;
 
-		spin_unlock_irq(&pps->lock);
+		raw_spin_unlock_irq(&pps->lock);
 
 		err = copy_to_user(uarg, &fdata, sizeof(struct pps_fdata));
 		if (err)
@@ -281,7 +281,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
 			return err;
 
 		/* Return the fetched timestamp and save last fetched event  */
-		spin_lock_irq(&pps->lock);
+		raw_spin_lock_irq(&pps->lock);
 
 		pps->last_fetched_ev = pps->last_ev;
 
@@ -294,7 +294,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
 		memcpy(&compat.info.clear_tu, &pps->clear_tu,
 				sizeof(struct pps_ktime_compat));
 
-		spin_unlock_irq(&pps->lock);
+		raw_spin_unlock_irq(&pps->lock);
 
 		return copy_to_user(uarg, &compat,
 				sizeof(struct pps_fdata_compat)) ? -EFAULT : 0;
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index aab0aebb529e..f2fe504071ed 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -59,7 +59,7 @@ struct pps_device {
 	void const *lookup_cookie;		/* For pps_lookup_dev() only */
 	struct device dev;
 	struct fasync_struct *async_queue;	/* fasync method */
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 /*
-- 
2.47.3

