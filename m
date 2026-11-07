Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057458;
	b=QkFdrCGDqtrp2JdcAYL3VaumeSrDC6WdmiwF4eACNOf0IaA7PNIqieZ3z+hxfBUtj1vR
	 bkWl+wPfblkb6H9fiH5/QYbRPeOepBzhHW6y4stW7dioObegFBloTVzsB8soz259jyHOm
	 YD+aZ+0LhZ+5DmQIVpuZtZ3MedF2og9x4Eodj8cfcf0MmfZ8woyA1P8SGGq7O8Y9Up+j/
	 SLgKDwGe2iivf+FopqVw3RpFL1mzXFEIzKVUiX9AUVyBhhvoGG9zoRcd3KsPCwiO8yp9m
	 Qfi+LhLMqDY1rzgHRdj6msbriKMukq12VdAUS7bXg+MEfAHXUtUyZNJ90DGzxgh4rog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u7PbzNwj3lxmkhNmK2fXXWzjk/jBMsgMw+OKuxBqyA0=;
	b=QJr0dO3BXocRrslhNK2ncHqHO9WDZn8/WRtuArjwAJjFp5s+PXqxpGHQKyisMIUyeEo/
	 W3sNN4VTvpij5tqO7+2Slc7IacJqvGh6Lg6sNep6Xu8/0qsY/pym/09hghXohAYbYoF7N
	 auV/2k6DWzMeAkFcGuia3rZcwA6xqo0qJrGTyKl70j3QMVuxxfeXiO5JVBLlmrIyKdbRH
	 dK+s+SwU+dppYNSnkdxBpwkd8v+jPuHF+rqV15M7FBJyagiiRf74xRB9gJ7l0R3MfBNhd
	 ZGpp+Uo9aGH27jM+lAJinvOGGnmcCCDFmtDOneTdWqE1zaTCfVtRM2jHk9SK4CdJPGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WTJKnj2Q;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD2606D80E
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 13:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BADD2606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WTJKnj2Q
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so13631605e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 05:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057456; x=1794662256; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u7PbzNwj3lxmkhNmK2fXXWzjk/jBMsgMw+OKuxBqyA0=;
        b=WTJKnj2Qa0fRoOAse5fNf/DDcC32hchf/+YuDy9JHq3tk3aQSa93KzPnrt1cP1+VkW
         W3IAtMj4hl+gN89pZXnVuR5JvXmLiGcvJfqaDF+BICWr/+Hgl308NYtg+ZlECX0GE0W6
         J4NBFpV89D+8Cn6/Qu2xIsH3La2ayMbGkLx5KrJUd8uDNXVsmwrP03xBNmhw3PDRa+9k
         LSGbNXoYVpaGgnHB3xiaMO8+x90Kl78mxYB5fPL2h+lsDrrdUHxGND1A+lH+oU+ecCEY
         O5VxROlcVsi55LxbwbeZqnyk2DoKFkOo+jS95WE1fMEhybDhZEZOhlbmSxrXjtkjWNv+
         OtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057456; x=1794662256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u7PbzNwj3lxmkhNmK2fXXWzjk/jBMsgMw+OKuxBqyA0=;
        b=SYR5gGiJwdinFx7yTK+Qwf4zxubZkubji0ofulVWBaG9iHSJr1DTEVenMtCOQfBbkU
         gcxpuVdP/rA56fuyDQAhtaSlRf0OVwveTL/BHs2Odi4e56nH0+gK1Dz13ZbJna6t3qod
         ep4IiGvRhqObLO2l3ujCdny0llIGEInYM0y9aojSTIZjXNkee1gjpG1/9LD7Hx08T/nj
         9LQmWjCUc0aW+XMqTCcd7SeWf2r21kd1o7Jt4xMDWr+d61LnCqC//JxJ2yKi6Fd8CQIN
         zyTbvOMpu9sBFBQjVNsOZOUFJ5L87fYPvYGr7ZrPvRFVRJhADdJbQlagc5H55DxZjUwf
         fSeg==
X-Forwarded-Encrypted: i=1; AKwUvBz74+0ROp5Nf5/K93LqnXulnrN/O7TVsZ7Z6EohKStYSTumHyf2ii8yWtOkYUkqEUWhmz+OqUyAdei6ueo7vg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ZT7Hm1Vy1nkLQO7k2wcGJ889LStqqAvJh+8TSO2bWvQ021YuX
	IlqC0V4CtbM+6IBb21u+NNhBss1FH/fOOIb4vtGOA8b1FARTZkZFhVSR
X-Gm-Gg: AYBFou23N8YNO9D1OcfhgQPAI2a/efgLQ0qXDJ/UIT/2Ybh5/WZ0Jl4IJIT/VfChNR9
	m1cQ2mdYxXS+gEHEvn79ydDxQVy2bDEKglUhwptY6ewECs9QJY5SZHDHFIhrnwYAHCsZuZGS0FQ
	6bvETkX2MopcP5iU21gdY/6Req5FY7e/g1zmHmlvcVZ6kOVgkMugXGqZFMnfdxnzx0gq2BYdwsr
	u39ovL5Q77gv90V376oG5pLcHNFgePsyVAIHNUI749G8h73vPpVEw0+xsQvNRGZfSyuD74XIrgQ
	a9z4/hNBXxbEcrYR9M/lm+OS/X8y7q9taMLg3XIcN0hz4Une8kg35EiK6N2P8G6l0FgNfaKAAcg
	3w2+mY8XrrqXkK9jgnDHvZnGn6stCY6Vq+yFze/HKgbjoE27AFDpBF7+uBY43gMO+ejhbFYLijj
	G0wMMY2AlVh/x2ypxskknFEucQx5rzku1UGij3twasBxM8vycRKIB8Z5yqVmsiBQZMPOdWhiqcU
	vPXDR7xcXjiDxCGPBOu82j376CTnEIHdMuG3TObfKYLc4tgzcWKN1y7T0PmLICAUGVhv1IculdB
	15CRuJv7UX+8flDl9FciRYQdRoGpnKZvrCsEUJWJyKK2WSTEFcO74MGnt7yz4TyDPYIZA6aVZBK
	7d7LKZUpILlxOJXzvnGl216mlgQwPAxBKjQ9otm2Z4dM9NDz/0TIg/M1Hqak5JH9hpyhCZQGcrh
	oCTGVmkTZovo9lWvViF9cIvSIMiG9Ur2A=
X-Received: by 2002:a05:600c:6211:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4b6df6df844mr101548725e9.16.1794057455872;
        Sat, 07 Nov 2026 05:17:35 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3279f9csm65132675e9.8.2026.11.07.05.17.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 05:17:35 -0800 (PST)
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
Subject: [PATCH v5 6/6] sched/core: Pause KCOV in wake_up_new_task()
Date: Sat,  7 Nov 2026 14:17:10 +0100
Message-Id: <20261107131710.89264-7-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107131710.89264-1-kmehltretter@gmail.com>
References: <20261107131710.89264-1-kmehltretter@gmail.com>
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

wake_up_new_task() is built without KCOV instrumentation, but CPU
selection and enqueue call helpers instrumented with KCOV. During a
KCOV-enabled fork, they can record scheduler, hrtimer and clockevent
coverage into the parent.

The paths depend on runqueue and CPU state, so coverage varies between
identical forks. Pause KCOV for the whole function, extending the
scheduler exclusion to new-task wakeups.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4bd0d5736ccf..a63bd78ce5d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5019,6 +5019,9 @@ void wake_up_new_task(struct task_struct *p)
 	struct rq *rq;
 	int wake_flags = WF_FORK;
 
+	/* Callees instrumented with KCOV would leak coverage into current. */
+	kcov_pause_scope();
+
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	WRITE_ONCE(p->__state, TASK_RUNNING);
 	/*
-- 
2.39.5

