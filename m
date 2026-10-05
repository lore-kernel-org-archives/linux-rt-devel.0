Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686044DD3AE
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Oct 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226717; cv=none; b=d9QGDSmXtKudoEuX0Fp8QKLrTHJShS63+/W5C/tpUkhAOwI5oUC2sYZfdxq0saTAkF6SSqNSR/XMwKbToysg803r3S55NJVPOql/UuSXUODS2D6LEw/krv0OeKVS37uQyBfPI2f9PeOOsS4VA8tMFFt5fD5IFoWKW2lf8lGJPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226717; c=relaxed/simple;
	bh=u/B9IvaEgiAIw9fjlzqtULKm2yBgA+iavYEM8xsWyAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iz5vKWQ5UCEEuJXn88js+nqKC59y1Fn5xOj8Js09chVVHCcYHvmS6Lq8tXImstv7GaKfhK1Wq9mUdb9zXWds3RbG1uGv2NmaPzSF2wtjnni2mP2aJ/1gnahUdGkWHAIx+8oNsJ3XO4zs2YMEwWsnVpxJU8ezC5ctBpk04ZCXvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6u+mUUj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6u+mUUj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d05d51553so15406035e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Oct 2026 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791226713; x=1791831513; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwC+jUdtFWGLh86kjV+y4udd2rd2bSTuCpSQzL1jA44=;
        b=b6u+mUUjab1JGQbY+KdIkh8Yp4zGtyG/GHq31vTxE8k7IGIxKKlQWEKyuMc4VKMkFm
         URjD9JxVFewEv7YbYYvUDu1Q0uebLW5vANlIQ2f4kY/Js2vBBf6b2IbWOjgDTKx7UGQw
         KlPuOsHttpSd9CoV0aVi5+QuQca5ic7cLY6lCiZ41ZjEM0i7D9hvDjr8y5ylW8yQe8gq
         onl3HxzppqTX0qKrmr50C1afgKaa4bfLE2TGSPAjqattnZBMX9VTqlHbLzW2crU25gZX
         MJT4OLDM4hI0hkEeHH20VXR0K20T/2jVHrsUa7kxjQraPyWQOF+rBefr/S//Qyg9oarD
         OI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226713; x=1791831513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xwC+jUdtFWGLh86kjV+y4udd2rd2bSTuCpSQzL1jA44=;
        b=eO+MchCtbsvWCLlf5b89ONKjMA3akWWGpGEMQeLS+BvJE29ILuqspE0074IUgeXcAc
         5wgCBVI/CEDpyMcYEg0EjbcJWDuj9nSiA2rveQtELsSHM9rjTMgaskEiOrA6GxJcwDRd
         w9UgvS0XnG7udv7daVxOkBMP01bW0EDtDUFe0pZoqAQpo1hFDFb3DlcITLpr/rPOVOBi
         RX258qxYjZ/f1G7ta/lx4rJC7/fPXAm898BIBckGO0V1rtMmjmv5zip+y5zL8DrBCGL5
         KbwsnqBbJMF+K5m/0OilLqH4EZ4QnrgsqCXj6ge60tUNEwsxSZMs3zgFoOI8nz0JR3cf
         fGWw==
X-Forwarded-Encrypted: i=1; AKwUvBytBoeQxsLzcZKC29TEWVGVTikfpgpDoDPfX3YHbuV/5yQ4Nyen/rx/W5+a4/yj/h8FfqOerdesVc9/bYyj0A==@lists.linux.dev
X-Gm-Message-State: AFuF++lUfISEPWsLxOZnT2KYEzmQQVBsCf4kvyrxPnaEb4y6ISv1cwmI
	K/D/M5OWpEiqyjfP6uPofjyXv9kAV86chXkTjhasEAs2oAfisAS6tja4
X-Gm-Gg: AYBFou1mDX6XKdD9zpfyEPE+Z/Iy1K9MB8S/lgZxkpRirvqPbY0zmi60pfUvqoHPB7O
	s/fFSoPLUdSyyjnLLwuUgHlJF7Oc0S6ZNMtDW/NEjoxYsFlD2WefB5knA3mMzl8oCKPrJO8rlgx
	U7sGgjZHKPkv1ddNrODG1TSv9Qt0eWCypj0oe6cysz5cPi8NUFO8B9C4iN/AyzRPeye+cDagAHi
	zxBENA0RbM/HIP+Z8abqBb2OEGjPjdYSveffFTlTJC+1nQpDOAACApbZU3ryEiJT/tTEVFbmdOd
	fVYKwRLCDc+u29fA59eBPOyzQOUIZKIU3rsQcqi5/Ou8KYwzlSLpPZNC2kyInUYuQsJbGhQ1ad4
	6I8CA0RWbpeODK5W1QQ+svYybKq/zw5y1cjYLB1ojmd/qPEKvIPDVz9uiIZhrGItynMAO9VqMxl
	jIrzr7O0l4BEY+M+1dJNI2+hBIMI3qKljFFFLo0mkP3hED/RzB9377uVmUMJ4JCLQVq64FoiVZo
	nKuaqifKruyU+S72GAuhxUIVkIbm4hkgzBaacqpfgdsItRZastElPVK98/DAy59SotHJX4olMcC
	jLKkxoYs4khHD5XWdVrtbSGFeqKERfz6Y7gXZPa258UoZgmtN3J2wXsLUvFnAG/EHqLjagzP6Wl
	vbg==
X-Received: by 2002:a05:600c:c44c:10b0:49c:fc6e:a3d7 with SMTP id 5b1f17b1804b1-4a1680f7b15mr98951035e9.22.1791226713432;
        Mon, 05 Oct 2026 11:58:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm281196795e9.2.2026.10.05.11.58.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 11:58:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <brads@mainlining.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] sched/core: Pause KCOV in wake_up_new_task()
Date: Mon,  5 Oct 2026 20:58:03 +0200
Message-Id: <20261005185803.39170-7-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261005185803.39170-1-kmehltretter@gmail.com>
References: <20261005185803.39170-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wake_up_new_task() is built without KCOV instrumentation, but CPU
selection and enqueue call helpers instrumented with KCOV. During a
KCOV-enabled fork, they can record scheduler, hrtimer and clockevent
coverage into the parent.

The paths depend on runqueue and CPU state, so coverage varies between
identical forks. Pause KCOV for the whole function, extending the
scheduler exclusion to new-task wakeups.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f19221282278..888460c97952 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4969,6 +4969,9 @@ void wake_up_new_task(struct task_struct *p)
 	struct rq *rq;
 	int wake_flags = WF_FORK;
 
+	/* Callees instrumented with KCOV would leak coverage into current. */
+	guard(kcov_pause)();
+
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	WRITE_ONCE(p->__state, TASK_RUNNING);
 	/*
-- 
2.53.0

