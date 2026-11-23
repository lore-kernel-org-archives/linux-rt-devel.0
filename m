Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455748;
	b=HWNPKfLLZgQf7olSe0Hp/oPeC+L+7F4dMdfajHTH6JQCHPG/IuScI3KKeeUxXPHaLuFI
	 av5ThdmQQP2H5Q+dfSLqkuq83ol6Q4jVILU9AryXW+4whx4Oqi8HXjRp9jcV97CpBQL1X
	 oBQFKrz5JxK+EYj2T/TugN4KXVgirRSRqHA0q30pA69Lk5usogZ/TqsYMFd9VwBMOu4zF
	 rqW9Z5cwPYet3rRDit9A4tIPKO3NOquHhAN6izXlIdkKz9Mn7KDhUIp8YgDMNEpEPCfxP
	 +xr7xqHzOJ4vBE74t5dPH1FjBeAagaBlojpwwjShP6JQLV3bHmhLhODYqikNhXQbCbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sjfp7sZFhOK52knRIHEyZ66Px2rvM9c24Jj9S6rf+y4=;
	b=twSKhYA89c1yclaOFFtrN3pjIQPFAjj7CNw0ySC88dQy+Ub+wJrBJHfqExcoySIaDqrI
	 WAgJ9lZqByck0e94YPRBQHklxZid5DCWKwGbR7oeWgYlknIdNdnFNpLMDuVFdfXuCRYEK
	 Bn/DuH+R1fbmgQBPvPD2p2q3TnMvdZzmYThzrgAewXJtgEVrA/R7hiRsOaZNGhnSnzux+
	 SoOFSoCQ3ejfpU10k3S+NU32T/oYqn0bMBMVCC/HwYXcZMxIvAoFN2PIusQ+igIoWvCDg
	 rBMbZ12/kwn7AWnYRnmWORCDBEqTeLKi3EDKPbS9+8NOlh+0e/pSUS7Eijiifkj4YhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZX+Xi8jf;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408D606A31A
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 17:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D408D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZX+Xi8jf
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b3acec6677so5075840c88.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 09:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455747; x=1796060547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjfp7sZFhOK52knRIHEyZ66Px2rvM9c24Jj9S6rf+y4=;
        b=ZX+Xi8jfxM/XlepCtbnz5htrEurBsP3q/cyKN8XV9/1boEQwTAZ+TOyyRQXjV6Z6et
         e2vw+y0wPhZUSb5CdNmQqyNECdJBoAcEQGxBBLevtJD1scp214lJjGK0gVOz1ZyZxdF1
         MT7BDREAPzTZvK82bkA3nWLzecOo8DNeMh2drdXwGRQW45bcFupS3IuQt2/ELRUgIxHz
         pfU6Iz39UM1bSG9FBCZzkFr4jeqD32z8WI3GsllpS2ZtEbP28ZP7FzsXcU6x2F3QsIOw
         TeybSstfseqJdiqQDXz+maZW8xJYgSUgZqGt5VyHJKFYJl8D+pRvzZa6s8hOEqCNpwCj
         zvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455747; x=1796060547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjfp7sZFhOK52knRIHEyZ66Px2rvM9c24Jj9S6rf+y4=;
        b=Ei71Ulg4NfzuRS0K4rAlpoE6C9S+YW/gmDIdtkO++2h6EA+HmXW2+epYsl/z0Xompj
         mrFodYtyomzYMUZn+6sMmtIL2Dv/8eMTLp+USWOBmoRnuRcJ42Hm3szB00R4RqY+OuK8
         0WSclt7QgZF6XIhpMyKaNLdEhgwoJpWi0JpYVHJXRcqu2yGIIPGPXVtN8B5ZkehU1gNI
         YPtMfswMmmyyAUDWPzc26jSL6HmV1iPoJKkQ9wvzQOSXX+xw3isf4x9lzAEWX+QoikhY
         pW337iDXnDYBcFsMjALbCqbNiWysU1bqKF8sN165p5zCx9568zbsXNYFz+7TyWYMwBra
         fsmg==
X-Forwarded-Encrypted: i=1; AL+hErG+budjNSWkqFzejO7BhZ6ZincOoOXvF2Wze2UqsMr0nHzUz5hJh+XooQPgv6pPAmoaKubM/J6VISVSCiO9Iw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/KtdfjmQhQ81ZYZOu6wueE/ESuskdq3eQyCykfWM49gkhm7/j/
	z5TJCfG+u1vbdHcAF6Fm2LL/QMy1ME47dEZQKJvJbbiC0kNwyAYHCB7e
X-Gm-Gg: AZFdTZfK4AH65oE/+3P9VG/9OStKJ2tZHNIhO15mbCPjy3lsgUmLGj/tyGV0IiKnSyf
	gBL7Zx5dn4cwudm1QKnxz5fmgCwv/ttriyxq9tD/tgg0d9SIiCbTsAbtjGw1RfrTHlk5SPPaCNB
	XfeFFVIyygPY5S5/8UJp/XVto+3fe00AjmRFqjxDWs8P/fQAfytBzM0WOBp95QooHl/hEgzyGOJ
	aU3UNl6nqGF8KzAZO37yrMrxcWuX3McjqHOWFJaA8K5cxkZJg39s5RjtZbcRLTb4iwIjoPiP6OT
	cH7ha3QExdUbxwBhpjmX1c+AFysw5SbErcJGMN2Kd1TLPJDb4gUA6wRSrmn9qERFz2tA5crLGBL
	DKqmFzw6FP5CR/9a3bjeEHWy1qN4wOKTz7PiYUhlmsy0DLiOSWnkPZ7iG+J53mMjx/2hWdHt06z
	jOfNOVHLYWHDDavFzdLEk/ldDcKZ1tgmjK91EeNe5lcZKrvz9mR7HyakWruKzDfBbm/mxuZSEqS
	eG5m/xIZ1f0WVfTDI+kjfKZuIkfwMbz0C8Ps4PhAX7SozastVeYbzai5enraJjRjr2xoPf3nmwO
	A6uqDLmAzNeB7GpEODGEn7ohj/veSdFLEg==
X-Received: by 2002:a05:7022:f106:b0:1b3:afa2:2d7e with SMTP id a92af1059eb24-1b5567dab3cmr10210370c88.1.1795455746895;
        Mon, 23 Nov 2026 09:42:26 -0800 (PST)
Received: from ubuntu24.lan ([2a10:8744:ed6d:42a7:c0c5:ca32:d121:31bc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm16613911c88.4.2026.11.23.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:42:26 -0800 (PST)
From: Yiyang Chen <cyyzero16@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yiyang Chen <cyyzero16@gmail.com>
Subject: [PATCH v2] softirq: Limit the BH count warning to RT BH lock users
Date: Tue, 24 Nov 2026 01:42:11 +0800
Message-ID: <4103eb7e6caea1afad16e5523ded3f2a30c40ee8.1795455101.git.cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
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

__local_bh_disable_ip() warns if a non-preemptible task first disables
BHs while the per-CPU BH count is nonzero. Without the RT BH lock,
this check can turn off lock debugging on a valid call sequence.

With CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=n, task A calls local_bh_disable()
from preemptible context. Task B preempts A on the same CPU, disables
preemption, and then calls local_bh_disable(). B therefore reaches the
warning while the per-CPU count still includes A's BH-disabled section.

  Task A          Task B
  ------          ------
  local_bh_disable()
    softirq_ctrl.cnt += SOFTIRQ_DISABLE_OFFSET
    current->softirq_disable_cnt += SOFTIRQ_DISABLE_OFFSET
  <preempted by B>
                  preempt_disable()
                  local_bh_disable()
                    B's softirq_disable_cnt is zero
                    preemptible() is false
                    WARN on nonzero softirq_ctrl.cnt
                    softirq_ctrl.cnt += SOFTIRQ_DISABLE_OFFSET
                    current->softirq_disable_cnt += SOFTIRQ_DISABLE_OFFSET
                  local_bh_enable()
                  preempt_enable()
  <resumes>
  local_bh_enable()

The warning relies on the per-CPU BH lock serializing BH-disabled
sections on the same CPU. With CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=y, A
still holds that lock when B runs. Since B is non-preemptible, it skips
the lock acquisition. The nonzero count then exposes B entering the
section while A holds the lock.

With CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=n, there is no BH lock for B to
bypass. The same nonzero count simply records A's active BH-disabled
section, which may legitimately overlap B's.

Guard the warning with CONFIG_PREEMPT_RT_NEEDS_BH_LOCK for as long as
the lock is optional. If the lock is removed, as discussed earlier,
the check can go away with it.

Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
Link: https://lore.kernel.org/lkml/20260310115534.3477871-1-jackzxcui1989@163.com
Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>
---
Changes in v2:
- Clarify the description of the timing diagram.
- Add the Fixes tag.

v1: https://lore.kernel.org/r/d9554bee441d2c763ef8d61e966a7a471915bbee.1795372382.git.cyyzero16@gmail.com

 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7fc2200392cd..f64f6b594951 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -195,7 +195,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 
 			/* Required to meet the RCU bottomhalf requirements. */
 			rcu_read_lock();
-		} else {
+		} else if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
 			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
 		}
 	}
-- 
2.43.0

