Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372557;
	b=t+92gB9Vz5ZHP6o6pxwyWP/Bjat+ZQ3+Rd8IcWTE5DGx2EEPxhu9z82bYXv7AFB4fBju
	 rxKySFbRw5ixJKaLYB/8rSp1QJDZKxN5TKwavatAdKNnp1QBSDQ0Ru/z954H1f49TulBW
	 UFbattgWTzZAZMouDpStkE/TFYZZrmdz0Oov5O+vpqOKtfBT31KcwCW0VKlXK1ZTk+XQ/
	 A7g6rzHmUWZMWxz3masPghBTJ8yVA4o1TtRbfxKSURezsj47+u8VoY6kZzz3b8Eu/2dY1
	 7GrVy9xWi5Hfje78JrS7M/6nfeSx67yNkk0qs0f3yT+f3GfxozitnOWCtTOyk0NlhFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TA+pIVlFttShEJ4Is+NIc/o3+s05F2oLSxfZfJRE54M=;
	b=oUU6UUintuSlzG8rzKhOI93a68K0CSgqXKwY69X2cZXQAaUmEGSGmf9133QnTWMUouq4
	 XAk9B+zVhCT/NPYD0eMLbTr3/yfVyMowRWQNvyhcur/Y5EWD39Iz5JlpC7qQP4d6hKh1q
	 jBsRtkQYTNxUgd2r0kNK57KPWY3oqEHRwWQKFPFCW++35zLbFan8xWxUPsnVhbEVcHBQ4
	 +s3w7gkZEHXPobGgXZYGLgzrC0MM9GYGMvyaVHo1k24k8GY07yR4TpZihhITHm238gkN8
	 j3W6+o4b1tmmT/jDIysyrey+kAh8/KESAHElGVYrSm8vNCfIDNov+7gJqnmsR3oqqMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqCA9x1L;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB1606A32A
	for <linux-rt-devel@lists.linux.dev>; Sun, 22 Nov 2026 18:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39CB1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqCA9x1L
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a315ed211so3300277eec.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 22 Nov 2026 10:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795372556; x=1795977356; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TA+pIVlFttShEJ4Is+NIc/o3+s05F2oLSxfZfJRE54M=;
        b=SqCA9x1LzSYHhb8ghuRVlqO9O1SRArgvMqYbEB6jE6qb3Z+ojBBQB9QS1fb//DetzV
         IIDCD6fwYpuRxCh1jD7F9y3yzmX71bFiKEAKQKj3MsODkaP2ZxnSmPJH42k3+Ttxt+4C
         vJLqnyjYtV9zAwvwF2QAaS6jS6Vw5fD3j8bZkmgm1fUfeUDjR/YakLFA0X2NKevaSe92
         z3CQLg2fsz9wSb2iKY6uFEwkGO22B4nzwJqzWw0JuzKvFg8AN1vGKHWeIGKLn0dRbvT6
         O0gHqJDM22kq4AEVkcoqch1p6u6g9+xXNBZ/3e8Bc5hw8MFSYzuoySjncR6LbVksLDSw
         AJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372556; x=1795977356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TA+pIVlFttShEJ4Is+NIc/o3+s05F2oLSxfZfJRE54M=;
        b=CFLisRFsvBqHPnYwFT7DVGMBAvVvPy94e1holew6oR2dLp9XM5INxgzc5mBlYnBNqC
         iCKxm4RlbCtD2WdsTzJdk6ORPvQwHNUVHYuP96iUlb6yb4CsShfRG1uMSjaXgGp5nmnx
         WZZt1NI7wB2gj991GjhHqJteo/9rU4xQBsovxXn299RgktRwVhDYcGRullI237lUDN4n
         qWxpimiDqIJAODdcHKynL2Onq4SBLhprNmmXeXdBTEB7tJQrRK3nPyxFc9CmM9Dkq++B
         lppUWq7JPG9mWP4qQG3LCx7rVh6PDHpM/HBZ6C/ceVDRdOTGcNZ5i2mrVUo3vz0WLOVp
         npCQ==
X-Forwarded-Encrypted: i=1; AL+hErHuXK1ZQnpUi+GxLggkJqOxySJQUlIKDVhpQguu0sBNFoWeOQYKXVaZTzpTtRIIihOQGWqMOMLyY9d85So2DQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/+ku4WsO+yUmB/rtgcf13UmVKaTgVho88lPhy4yfCZQQoRTqd1
	h6mKSwqNAApDpzR8wiOJnaoyqLykzVpdMTXQLSa3xTToTHNqEnjeM46d
X-Gm-Gg: AZFdTZcDVuOlew7e5YP+eX6/lrJ0SpHBc0RliDXz+TZqqSsRyJXixHDcm5DDoba29KB
	3julFE52uxJxNbMT3VcImUvFTwKAizDmcVKFzxH4sb26sd5UizKyWIBSjfLtt2vcoUrm6QAmF2O
	SQcNZWx1GiFM2dwHcx5M5DcqA1h2uHayk4XK42bGsWyRXmtPfGHKUbTv5ekXzJk9YyW1Qmko5Uk
	3Pg793/xnC0WcaoXE5CxqmaRWkVWJ/AOpr3/x3Hnw5iE9RQRXQIe7PR6Ll2iDgFeUsGJ6rrPel5
	5ri/mD8eD0wyNvQbyn6P2zDXnhPtPpEG2PNhConapmi8zZ16QQRPptysrpHdUsDRKhYFQbWreFC
	QyQ8LTBEv8RUznR22qi2nOai0FE3vsO8T40J996GRGRvvUxu80fmOHX3UJ3WIRPmqIyI4JTCBD3
	wgGBMyQPbTQK8VzuXWeTxZ3aDozyW0+muKAQAyiOpreKotG4py76FU9R/juT3akv1ILqhfBYESn
	5HWs/SlNseIEtjpUSRlqpSSW45GrcQH8LNgbPWGXFn2duZenewX+08kedVfvySTkyRCs7JD2Vas
	NifNi0cSyOBiAHGTJSfsZ1G3vnPsWTH+WvX7+doZWYXU6N3hvSWy0g==
X-Received: by 2002:a05:7301:a0b:b0:386:a416:6c91 with SMTP id 5a478bee46e88-386a4166fdemr3601095eec.20.1795372556143;
        Sun, 22 Nov 2026 10:35:56 -0800 (PST)
Received: from ubuntu24.lan ([2a10:8744:5c98:4c22:e925:ced2:1029:b0e0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm30280810eec.6.2026.11.22.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:35:55 -0800 (PST)
From: Yiyang Chen <cyyzero16@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] softirq: Limit the BH count warning to RT BH lock users
Date: Mon, 23 Nov 2026 02:35:47 +0800
Message-ID: <d9554bee441d2c763ef8d61e966a7a471915bbee.1795372382.git.cyyzero16@gmail.com>
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

With CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=n, the following sequence is valid
for two tasks on the same CPU.
Both tasks call the BH helpers with IRQs enabled. The per-CPU BH count
starts at zero.

  Task A                          Task B
  ------                          ------
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

Link: https://lore.kernel.org/lkml/20260310115534.3477871-1-jackzxcui1989@163.com
Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>
---
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

