Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195C1E0DCB
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Oct 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760319334; cv=none; b=lvSO/ScamtQzqKXYVpbcjnpQCbLY2iyFGZrULj4zsRFRTrSf6SfJk0J7ewTtwAU12e3EneyMN0uV8gY1m5jj0IW5qq13V4VGHTA3MTTvkl6gYAYTak3OfrILuD43u6QoXYa4WZZQOmDR5cOxym+X7jroZ1MBaKPYT6zPUyIETWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760319334; c=relaxed/simple;
	bh=SNT/gQXeYMQbe6CiuE3g4PgI7DmGrmHhWTT1uedgyFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIcKfpFmeiu857z45qc8ZiJMw4zzZiQeXqOAmKUa9t25HPee2baxOnL/jKtM0APj3Wf5vh8DuHbgk6LP1UgE+HfvUVe2AqWqJfiVpHulkAZfu1loXhTH1VUuIVvf2xCNzhYb6z6ZwxRJrx/67wPx8KWdN2kKQ19slbyVmAdUN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTEVuN7w; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTEVuN7w"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-271067d66fbso35693365ad.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Oct 2025 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760319332; x=1760924132; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qptI1D+UsB6BnqEGTBrzAfay9TK/go8UORV6E6C+E8A=;
        b=gTEVuN7wchUjEI1MNJxvvQSxk9E8hN8DH5MwY4St7Flo4IDpWmAsOQQkeqz2mfl8g2
         HfXAYJwUoNSrvfY7HaXxfmP7qZ8SVznhOE/8vBFPljZVLRKiyUu3UF4ZulBzuFaiq06d
         RrXEe7ZcFVCzE5wa7eOqmGXWv9pSGnIhYDyoMiwvRanvJEfY+TLGMo5LHkp0yK3Phgvk
         c0oFWQ98cTqDEjvr691+567Piomvh3+eHGUZdkHjOwVCLbAVItYeTB9E1D0lRxDHbJ7u
         zm5RQW0ZW2/XdmZRgp5I8tJ0YAAJb8gtgZxqvqMyehNoIL1DollTLJTcisxW4yE0cQ1F
         e45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760319332; x=1760924132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qptI1D+UsB6BnqEGTBrzAfay9TK/go8UORV6E6C+E8A=;
        b=ISLVMTOkt3OHJIu/DyP2HssPmFZDybShvzpHx1FFVjQRa/0zmlc8vSW7Rt2Z3cNqjX
         7bvH7SuUI5b2e1v77/G2XdTRfzRkJ80pSyWTyBg8oGyqJVOgD2B/52eUpNYPwzXp9vnL
         8c6RDJswVd0niJZNDld49MiIF/jeyNybZw/9NpnzLOB6uehM7omdg1AXxCtmvoK1X7Gk
         /9y6xN5ZTh5hk1ugD02LcvUGgNlAHisk5/pL3eQgH0cSh35tcIc9PeXyRZAC7kws/FCc
         GZzINc371Wpk+u3rG/bPL2cVwDBAcPRzhcuJv9RZabQfFhQp4eZGQfmCzPAZIYsECUJa
         PANg==
X-Forwarded-Encrypted: i=1; AJvYcCU6qA6uukbD2GFTHLk0fIzW9ZJhmaowz9ENCRxBhI7avK+9HYABJDEqpl4l4x8CTgvQSRNyZt30baunCfv2lg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1jsqTTcKM2+H0HENyNjM4AULxm6HIXUgupp5ITJ8R4I9DmJb6
	2+t9467dqd10KpozOYbiRamP0PivmTZkKjxhZjvUGGI5JzVmxZLJwl4i
X-Gm-Gg: ASbGncs1rEvM4cEGGW4hfpsSIxphjv96y/keCXA11DgIZ105m7NlWSRHMO1k6fAIcLj
	lHTyTeYnkFfLX7lbfpHrtCJ7PM301MDHEPgUGzYc1piaa1+TfcYcT+MUhJQfvFbbyuS9/OnEi8o
	lOzoCB7E5yYr1B/xR0JJ+JWl1mb0L47jG2zPTDB+SV8pLmdQ/IqCzXmtPiTdAq4ndjElgidw01C
	Mpa+4JV5VYxD3GqCCxkZF1uLyZEOK2KegWlow5l9cLWbCBuNykdKUKzRm0WjchWvGkt5EQVwHkH
	TYACscGQS2BrcKe6nucpGOEbZRy2yqW+uOJxEt0WeRzKmdcxEqvX0mI4NrrxUKYvW9nXSw9LCNV
	nVuKMMVE2um4u+li2XMvGHHdSLzIvxU3SdJyl/PWDCaj48NaFg4hkzCUKGCZccnYjmr0/7k1T1p
	GK+5NTIi5+bEoujDC+FeM/
X-Google-Smtp-Source: AGHT+IGroTw4Ts05YI4y+eOASl5mjOVLbfKOD2hQkPWmmvN/0O+Vt+Jh4T1ULkHRoFOV/204fLbaYQ==
X-Received: by 2002:a17:902:f641:b0:28e:cc41:b0e1 with SMTP id d9443c01a7336-290273ef139mr239114615ad.36.1760319332207;
        Sun, 12 Oct 2025 18:35:32 -0700 (PDT)
Received: from fedora.. (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35e62sm116996925ad.88.2025.10.12.18.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:35:31 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	leitao@debian.org,
	mark.rutland@arm.com,
	ardb@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq stack
Date: Mon, 13 Oct 2025 01:35:08 +0000
Message-ID: <20251013013508.74677-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For those architectures with HAVE_SOFTIRQ_ON_OWN_STACK use
their dedicated softirq stack when !PREEMPT_RT. This condition
is ensured by SOFTIRQ_ON_OWN_STACK.

Let arm64 use SOFTIRQ_ON_OWN_STACK as well to select its
usage of the stack.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---
 arch/arm64/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index c0065a1d77cf..15dedb385b9e 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -62,7 +62,7 @@ static void __init init_irq_stacks(void)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static void ____do_softirq(struct pt_regs *regs)
 {
 	__do_softirq();
-- 
2.34.1

