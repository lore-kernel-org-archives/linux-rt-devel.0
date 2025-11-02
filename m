Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED91F03D7
	for <linux-rt-devel@lists.linux.dev>; Sun,  2 Nov 2025 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081081; cv=none; b=HAPupBb6vMHRvD/fYbh24Bl8XArWNoeAe0cTiCqQEnTBs2bYhP/rW2SMBqSgGejQxczvPvzWbgWLJGF84VkArG+xu1X+eSfGKAANzCpwcT1rCecQVyc1/LkFrfA8zNxIC1aYsmEruwRm0agUDJRR6/KQhB5u8ff1AWh80ku4XGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081081; c=relaxed/simple;
	bh=YYUim/jEHT/moxRP+um8D0ezgl9zrVelNIUP/7RdRq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMAYmmA8+kbYm9msGT28GYLs0cvFq5g0tWDw9635Jmb2N9hB1g1R6Ed7thXYR3dwIjcfaTf5cX7JCFXQM5dJSs0g7r1GOyo3rdCP8QcdN53dtYyr4ojGqJSNfSG4TzxwgITWd8OoOVlQ7mRw2oL/I5xvnK4pPwHq/x6tzCxLbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmRa3UB/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmRa3UB/"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso2661039a12.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 02 Nov 2025 02:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762081079; x=1762685879; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IacRLUig7UN08q6stRj9OVGSX398h8U/Zz2TL8Csh6o=;
        b=jmRa3UB/RrSwa3g2MNfZUW22kBNjJkqvyEIcYUOOg8nUFH1guOFR67zpnDSNnqsIyW
         qeVvf3pWa9nkw2vsPolnP7gHbcHPKvRz15QxhtzTJGfrmwJxkVVbLCrZPrxSG+Lu7db1
         9ANa2bSrt6HID69XyzgB62CaRoX+dXvyf9b5tQZca+66J57oNjQ78SU4RUn3IVpbKmZY
         OgAi76svY89zz8acoR13jeLo9rbulGizLagwG+1vETmKo2oRUk9Tf/s3O5pEB1v91WUG
         U3BM0CtSuVDoXWpD95d+xQGKY0lX7PmYZyR4x3AZJxUsz2R9u31REpnlkZEP+hdmtRUk
         Na5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081079; x=1762685879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IacRLUig7UN08q6stRj9OVGSX398h8U/Zz2TL8Csh6o=;
        b=bOYpQgN3zMQDX5oiZkoi6Mp4ySGcdMqloL8nRTLjjv2VaKSyrTTxbIZUybCSG1tzD4
         P/eNRf2GgZaCpYNgMa5thatNKxesroEieX1ww+2w7aag947KsaAqweLd7tLlDx0cENIF
         v4vVCm5vFJL7juo6cI2BCnl9X0qEYF13UvKz6SdfXtPhWdV3DKm/NL0vgoShBPna660m
         Jsvj6hw/vV/CTNK49ZDM1OPxv0WCF7Rrqd8GVwKTC8Ktn64iJ7P0eNeN51lvNuSXw9GM
         Bx9VhYs+2XcBDr6QGhzNEU6yXAV4LyIg1UL5BjudAkhx5jDwjOqMecs5To6LPoczGlw/
         vVVw==
X-Forwarded-Encrypted: i=1; AJvYcCXsIl26AEaScq02MEoEo57sjOu/nII6NXuzhErdF/LMpGjnMVnCRyo1Jepy4rCcQx0/BmNiMkCBn3jba+x4uw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy993wuX+nNBpbDo6Oah/pV6ib02jeWQsSgQriOx7gSUIgienQG
	RMgYRLFLbJm/jObC4unixnKJHaVKlrI0IvcWe2eZEyFOV1iMsElBEcm3
X-Gm-Gg: ASbGncvSDjEbtfCfUW02e59khRiZxc1zw+BXwJF/Ax8WJXNcSa6ffqX8JSqae9RIiDt
	YZ3UdQUl1Y5DSrIFkQxfIFbNMAygzN18MUGM1vWrSk/Ly+oOwCQ7vC2/38TPvwY5ZLhGzzXOy0S
	8IYvm3w7QJMjWySElU/xp7knBrlIKVq1FCZsWZcFFgCCOxW54pbZlyrpAp9gDTLHc6WKIR8AR8N
	QJYMaL9iIAGPsf4H1t6ER0DikYoE2b825Q5reXXf3BUuRAFgYb4apPsoHHFaEW8mQjjjL0JV7S1
	ew0h41v/hCfJVVpPJz8yMsAG474Au9J5ywgKSKnvYnwOxntVzR5pMLUz5jHfY0MMAMr8/1/ZqH5
	Nsdl2vfOP4n2m/U7yWKRMwWLTOuztgQOXlLWMIXkeJx7eO+NnLbbC+giLOg6lMP1vGmgBhZAdju
	Jm1fFSfHKZoTGxAUpJaK+sHxRLCryPiZEHfLLinfM=
X-Google-Smtp-Source: AGHT+IGOHUTKi0otXLZWZO3UtF87Lmbiwrz+oxQ9CxZzdYea045bCS6cyr2JFlyOfDjazcyhJ+6i0Q==
X-Received: by 2002:a05:6a21:999f:b0:342:77fa:4aa0 with SMTP id adf61e73a8af0-348cc8e41b3mr12903852637.31.1762081079412;
        Sun, 02 Nov 2025 02:57:59 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67999bsm7488050b3a.56.2025.11.02.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:57:59 -0800 (PST)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v4 1/2] PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
Date: Sun,  2 Nov 2025 10:57:05 +0000
Message-ID: <20251102105706.7259-2-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After misc_deregister and restoring PCI bus ops, there can be no further
users accessing the einjected list. The list items are therefore safely
freed without taking the lock.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 91acc7b17f68..d0cabfc04d48 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -523,7 +523,6 @@ static int __init aer_inject_init(void)
 static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
 	misc_deregister(&aer_inject_device);
@@ -533,12 +532,10 @@ static void __exit aer_inject_exit(void)
 		kfree(bus_ops);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
 }
 
 module_init(aer_inject_init);
-- 
2.43.0

