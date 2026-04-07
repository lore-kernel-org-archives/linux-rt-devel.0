Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397913FEE
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Apr 2026 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522773; cv=none; b=YQnpndhUps6dh6+PPnmuEGC5QM0lZn7X6alCAGPqs9VVjzBJhUD5jG9zVvSI26A7MeP2mV7XDyraNZnRnzQSTR8Z6hegUCk1yZORbMy/Gm4QlyQ5ULIhB4yCuTtDhdluKzV+qu28M16jsomWRaifOmvzkj+Nfh4melrSeS3vS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522773; c=relaxed/simple;
	bh=WyhwNuIyCdlCDOdumhmrb3Ca9yjccs/vId8OlVdNMMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r+5xo3RIiDvT3nni/Vsu3tUQz3HO+o5+q+fL3NsMS0hhxxTN62s5QW5hu2k+hhhWpj1hxVb51Yi17NyXHDWvBDIsGU4+0VMtA4eTZ7KdmivwimB1ESMzHc8Bdiycvtfa6OiABoL1O3SZtgs3z452r5MhmkrjWUoGk30zYC0jeNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1cqDG9y; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1cqDG9y"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89f68634786so57410436d6.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 06 Apr 2026 17:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775522771; x=1776127571; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVClSKROVTZHGAQRCCvPATSi+gjnZ5F0+pvtkkRbZBY=;
        b=b1cqDG9ynYTDgb3VPQ6/P5uDmVpna1h45QNg90y0I/W61KR9TzQku4/GvMr/Sjh0dF
         mwk6j3VLcEynNyEpSZj6ASGu7r4D+aR2zGnuNxsomfOn1xeWtYRmY/WQlzplNxbsleQd
         djMlsk3Flp+M2NLsONNnxM81B5H3AL3hJCGsE7Be0EiNsVbxILm0+r/Nub+fa2eeWTxl
         eRiQ0p4tWffh4TL5vD57snOf2VYezYS4aTYtfNlVOlwjxJPtAULG62BXllo7d1QoPJll
         TVyWvr5jYjqGWDJXKdz+sq9LHD9fjXQEXp6qfSPdloRbeJwu5iGmLo68b8KI9pqf65CP
         5rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775522771; x=1776127571;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVClSKROVTZHGAQRCCvPATSi+gjnZ5F0+pvtkkRbZBY=;
        b=QO44DpO8y6sfPl2pTSJz/cYQixw0nAwnhptkp0NiLTUQOvwZjsAT+WaU/RNIZcVdmx
         7Wwx8vlIEpYAPQHuRwPQzk2ekApx1yF76OymlpGchlOZp+dOEUYbf1/uhNZfeWmpOmI8
         4xD/85omz/kEjyv3NpxM9fBqyDAcraIPgLGnX9XpzJnqggVFLjkQ0p1aUf9gQ5BHPqED
         1gt7Hru+awrpMirk/rEsJ28nJ+UXWa1vMYt+qkVyJS7YS9Ve1YFuKAijQkZ0zBJkuK8x
         r1jTO4nyvYn0AmLKbNMvqqa2puJ75ml2CtB0pEhQjFAM+VkFNahGVHwwke6nyBY1tcQj
         Zhfg==
X-Forwarded-Encrypted: i=1; AJvYcCXIPefe2crgAZkD8RXEAZMeKI84yUBvYH/x2WPwTRc6GqIQQ404Qe8TU00CaFomoGminI3QSKxcCZpsVuqeIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXDKU4ar6ONDdAAQp7z6xQAiGhvn+tb/UH7dAgVFBQJ4oZtAF8
	4onL/RZurFJGn3+D/NS9iI/uTGA8B4PZBnMpPs4x/NLvcf2PIeFe3b85
X-Gm-Gg: AeBDievBLF/qGnxriG5x+bRq62adSdgj/tnfMMUnJH7LXUob6Grvi6PWVfpthSYAGe1
	E4JZ9EjbYEZKhXfsDOO+qHsEMGHfW9rRxskzK6k26G8dmCFWD9i6BuvgaFyP/Xy1j0M184RVm4K
	BibQ5IYGzUSLUADEk6C5ixeBYoqVqV93wjtCJ413W9hgh42tUqpDKHoJ5hQMdIbsx2kqtLPHcgE
	P98MP6ed3aeZWUyoAIL2aVgt+KJmZK2lTubL6TtCpQQmpvlm3CepjXSEThF+Gz+ZDCxqShmK1oP
	61VEnv8gGOOwtwq15gYTquIoSnRdeoi6o5KZW/lm3l7chLDEhOyqG6z5SRkGh6ebglaz/jtojb6
	UNYDbVhtegia1LPybWSLqnh7Ri0NrsYnQC1H/ohmI7wIJndEzLaWj/JmQcnpfHppUpSrdUY9RXe
	wzTfON5EEPL5HVNORVxrQfDFScrgJ4W3s7
X-Received: by 2002:a05:6214:4992:b0:8a6:25ee:fc53 with SMTP id 6a1803df08f44-8a7020bd406mr260799546d6.5.1775522771182;
        Mon, 06 Apr 2026 17:46:11 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5974e8e8esm134853786d6.43.2026.04.06.17.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:46:10 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 07 Apr 2026 08:45:39 +0800
Subject: [PATCH net-next] net: macb: Use napi_schedule_irqoff() in IRQ
 handler
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-macb-napi-irqoff-v1-1-61bec60047d7@gmail.com>
X-B4-Tracking: v=1; b=H4sIALJT1GkC/yWMQQqDMBAAvyJ77kJMgyX9SukhiRu7gqtN0iKIf
 2+sx2GY2SBTYspwbzZI9OXMs1RoLw2El5OBkPvKoJXulFEGJxc8ilsYOb3nGLHV/hpNb2/Weqj
 Zkijy+l8+QKig0FrgeZr88SOFchxh33/pNnkgfgAAAA==
X-Change-ID: 20260404-macb-napi-irqoff-12b3f4d9799b
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2

For non-PREEMPT_RT kernels, the IRQ handler runs with interrupts
disabled, allowing the use of napi_schedule_irqoff() to save a pair of
local_irq_{save,restore} operations. For PREEMPT_RT kernels,
napi_schedule_irqoff() behaves identically to napi_schedule().

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6ec7b110dc7219ca337de4c6f0cbe38bb11558b5..322545b3be23f8d2c4ca2e3da61e057496458eab 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2149,7 +2149,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			 */
 			queue_writel(queue, IDR, bp->rx_intr_mask);
 			macb_queue_isr_clear(bp, queue, MACB_BIT(RCOMP));
-			napi_schedule(&queue->napi_rx);
+			napi_schedule_irqoff(&queue->napi_rx);
 		}
 
 		if (status & (MACB_BIT(TCOMP) |
@@ -2162,7 +2162,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 				wmb(); // ensure softirq can see update
 			}
 
-			napi_schedule(&queue->napi_tx);
+			napi_schedule_irqoff(&queue->napi_tx);
 		}
 
 		if (unlikely(status & MACB_INT_MISC_FLAGS))

---
base-commit: 816f193dd0d95246f208590924dd962b192def78
change-id: 20260404-macb-napi-irqoff-12b3f4d9799b

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>

