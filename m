Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073F255E34
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Nov 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328620; cv=none; b=b0ckwNDCYxmv5hy72ZM9phPlBCMCqOXrCWw47nZ+l529Y6a6AQ1ZZI3LeN1B4w9mVEB5YYhgVjMsk/ClSf6f3/0yKn6tYfYTkAmw9gmxh+uo0gu/zHPh0WP1cBgKLeIk6lVHO6SP80V4nlndGtL/RmhNl0eu03LN8sTNW7mUgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328620; c=relaxed/simple;
	bh=F6g9/A3XDIA70+2v7KFfVHx/BGh5EQx+QdUDajZfXlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZC3KkqUzwYqXIa29mz2E/ZBcMK2u9ETB+SQG4cfDM1DSgWdr2PZVchvMysMu/+3ekqMAwaH2VtGmm56V75MlTCBqLJpI8+rDPk42XTOZ0n/uhn3egDKqs94H/rx9/Z91GiV5tiUj/o4V+OvUK4oQUQErgH7hAcFcNhAj3EcOfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIMP7r/a; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIMP7r/a"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34029cee97fso6603079a91.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Nov 2025 23:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762328618; x=1762933418; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqbaGd3ujMFfuQvly4MTGTSUQZsIXSUIxiFKueQlRMI=;
        b=kIMP7r/a3dj3GbseG34bgTm7uP1ePsETZ5xSWeZ5/49y8uFw/ZYevl3aRZQfu9iwhs
         ALYskePL04KsWRBC/S4D5UMIV0mZpMMdXS6ZLjLy8yovQH5aUW/SGAh9+jXLszT5QnHh
         VelzLCpRF+OP2A8yonTNKkYu2DyJF0sZCgDgfHSx/9VgllkDSiv2XL0bmUQTQDrCxndm
         cOMwK1bY9OTNWBqA4koD5MkaF7r8aUhcCi5EYzH8H9RiQhTirAEHleZ6XOCuuXbyEqrJ
         98T/1Fs2mjM6X7T1hMZxsZOicibZGr6p85DYyQKCrX0pyoQPsY4Afz9qM0Ruv+8/zWsw
         Q62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328618; x=1762933418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqbaGd3ujMFfuQvly4MTGTSUQZsIXSUIxiFKueQlRMI=;
        b=ogFolA2CPYTbmS9jMYmXw2TL70NBxp3TXr2W8itwTAZfmui61Wc/Z2s+FAX+ZMqzga
         gP77yLtQ93YEM2Wj55pcVoKlNFoNUDw0T9EQStNeuSQ78mRAyRhJJZN2Yl0h7/Ye/Vtc
         42HnBE2YaX3sOC6RCfPgQGuhk1XeAdDHUnqWqfwv9RInVgfVhfPv4PIAFON7fFqrD1LU
         1Rk9vN4GH8QDM9l4onVN1bWarxVGYeJ5Gkp+BrQRtSWpjMb0Gz74dsj6/YCeRNwRccZ7
         HN31/wCN9mAcXkWLc1DwX3QyR1SizXZBT9LcMZOrTau2Du/eUj3J/VEhEfokHCQvbHwh
         CY2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXxQS1wQ52I54+sJZ44JtjN86erdfAkzXttx9GnQAUp7Rq3abAW6xkHUczW9x4qmBq1Iv7Sd1ea+cENGJhYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvuCB2z8Ewp6mprqhlGd/VZ4fBSpSp815zF98PagGYph7b4Hf/
	STk0oX4ldXsY516zkt2v/0VJQgWAb7qyOQGfCY+8ZBXabNfdPejeGeDx
X-Gm-Gg: ASbGnct3bG83aYaSkhO8ypZtK8Bt7IN5NuXoAzy/bxfTdURd7mlZuAihd5XnFwLQ7w6
	70YDP1yiRQJwIiSi42R/QiMvdRMAoJyYIOLuz54isZ+3fYM2/16LdVDfe0daVxfd4JXBYJrsnvR
	n4wosNIPP7QzM0r4Wm2jaWLxB1szsdW0tHLLK1fM37zjmMXx3A6UkU9ypCPF2ylIaJk2sy074+C
	VVaAAW9GHMuVBdmIFmU369lJIcA5x6K3ntdgsizGT4tn4z5mCclu64pjAeuS1PeSmBOl9DKgqol
	9IYKhhK0nwGekWnXYACYzjXcBylEf6U2lQjfhzOhaKZ0MRG4Jq+aol4cnV2+ZZY/uFULXTQ7dfd
	+7uS1O49ynijOFX8swaXHg/mi3IhnANN2QuhdDdn4ox97vhdSImCvpiE16FIHCGazHj444w1VhN
	UgHbKu5xPVtRNDuSRSnYnc+UGGb8/ucSTLq2Jq/x+9h+Nvwg==
X-Google-Smtp-Source: AGHT+IEPd474pPje7iLLe9uuqifhc8lmW7a9y+LRT4XgZRgbuby6o4bf268JRA/KDPXfx02yR6dTsw==
X-Received: by 2002:a17:902:dacc:b0:27e:c27f:b834 with SMTP id d9443c01a7336-2962add0774mr36068595ad.56.1762328618318;
        Tue, 04 Nov 2025 23:43:38 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998eb6sm51062025ad.29.2025.11.04.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:43:38 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: will@kernel.org,
	ardb@kernel.org,
	bigeasy@linutronix.de,
	catalin.marinas@arm.com,
	clrkwllms@kernel.org,
	leitao@debian.org,
	mark.rutland@arm.com,
	rostedt@goodmis.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ryotkkr98@gmail.com
Subject: [PATCH v2] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq stack
Date: Wed,  5 Nov 2025 16:42:59 +0900
Message-Id: <20251105074259.209131-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
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
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
---

Changes since v1:
[1] https://lore.kernel.org/linux-rt-devel/20251013013508.74677-1-ryotkkr98@gmail.com/

- Add <Reviewed-by> by Sebastian.
- Add <Acked-by> by Will.

---
 arch/arm64/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index c0065a1d7..15dedb385 100644
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

