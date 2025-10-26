Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBDD229B1F
	for <linux-rt-devel@lists.linux.dev>; Sun, 26 Oct 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453849; cv=none; b=LgZ1uExq/JXnDNVsl/pssdFCRSimMYybaGFhCFIQjApeEhZU65ig5JZs1dnlF2000s1DglWOqML4LgYyneQJ4tMuDp+RX+DNcIo6EXcpt+ZKGaGOVuOWKgqMMXR7UcrMbLu5dYaSBTAy1oh2LIv2omgMHpSHs7qY/Tch0oI3Mfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453849; c=relaxed/simple;
	bh=sAHI5iIZM5NABgTl/sQiPfhdR+xFRe//xBPBZe5FW6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO31ZwfsGRU76Qvcr0GMZ0kcRgh3arOnRDJ0cXLlVQkNISqbIVZEoP7bdiWWI4nESsATcbiocvxU+q6uqT9z/6q/oHAeM/9JYlZUfzr1PgvVFz4rOHpVVkGt+61HoqSGD/O9MeBOmxfMtGOvrp+RP8WmU/WhsBtN/9BiEMP6EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfiavFle; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfiavFle"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290d14e5c9aso48065765ad.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 25 Oct 2025 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453847; x=1762058647; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk1/Yc6Z7SPwqUmBl+xKHBmZ07J03/Mj+lkIe6IoAeo=;
        b=bfiavFle56rIqNFCWHY4qxvd6yguMRr6ec3yhRzYbrC0Wqi7l02NU/ZQheAtYbF909
         pFkTo1z2EtN15JfmrXYO6lt/gXVnb30Yzf0GTslhbBja690NX3oN6fLkLP45rN3I8wwC
         /qKvYeSUVRXSvsQXn205gIxnKBjVonJ72vsNsdrUHhPwspbeP7/ZQEFU8BKFaQ3ay28C
         4pMNAs+3Ird96eu8OLtfEgWlFsKcQp2uBriPjjX7GzLhNnTQ7J8fGayT9N/yqQeX1z64
         Ln7II/iUMa95pztCw05ioU7U2Yv+p/l5LLct0kGWllxML/6oR7pE6G/A41VpY071Br6e
         TXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453847; x=1762058647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk1/Yc6Z7SPwqUmBl+xKHBmZ07J03/Mj+lkIe6IoAeo=;
        b=bSxEMcDhNXIjfDZN+C/HLdym8hP6dw8zLI0GpjREbMFYEIzl6o1ZHzi6RWMGF1SG/q
         SBwfDCEcqvMqEMh0ONI4a/2cSEzYEblQF6FIH1rszJSpngrwWOZ0v2fOoO86P6JD9qHK
         9EY6Jm7WHr8hqKG7hyC7uFrwdrrC97IfOuqZFB0dYjQ0ejcepZ2YrOzdlZzVU+DCNTI6
         eP/9B4Z0JEcLR5xvGQ92OnU6u64nBbpsqRFI0SB3xZs566pwcO6I56lQoXzpczWZGUBP
         RTM6T1VEoXBAyGJTV/j16hMF92ipPLcY7JnisVdzkGFy2yLLp9WarfGH7yibAoZmt8Am
         P/zw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Cc+NQxAGwrUTvdMt/7z6porCCSTtA/cCIjeXlci1FhywxuH32oXvUMVUM7p031MfQatE1BAtDrmCDqAHyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxTNtJEWvfcBhLMD3xvogEIE7gNML15cpqAdkJ81jGTF4uEQyl
	yoBvlopdruspw61mVQTNukCI9XqqDDlGJl7xxJVlgv+d2tl1IP8wjNKN
X-Gm-Gg: ASbGnctTIzZZ8H4DmotkF46UtrcxcLHpYmB+QvQldlpI+K6/gprDWWJLbpCAu2DlOQ0
	ujShuccagjRM+vj1yxPTk8ug4JMOjkX3SqysqDbweslDsYuN+mSauHq5PoaCvc+/VT9q6Z30vgN
	Zfxa0jIvn/x2l3brKPwMYERJTw0tbr9ue4U6v1+IEttYXuvnVpdGpa92hXpQff5AiRj3jlG3jvc
	DgA/eujeALCADV3EB5cVYpEyuof/e1N4xGQFcuF3/dB5ItOdWYNHK5is7EdzuOg2s4uPtWneNAZ
	E582zOdjf3uEYNH8g8Ihx+WnVAz40LW18ZsOyHZwjOdbdIjwmPj0BiC579tBcjnIIxDqDLlqln9
	xHZ352O8y2XOK+n61rPBwMpmBpKs4JNY53/pBmdbnxaesVIzcUkJavYNI2sOFkSaR+mgVAt12r6
	rUv9Y9E7it+Zl68d6188+2sh4LbGrzcQ9nzrqV8b2N8lmILxMgfQ==
X-Google-Smtp-Source: AGHT+IHc8dm0fiYDLt8rU8qfupJlNJN9BRtqR20SQ0bZw140gD/aS1oyiyBfrB9MNCNRXcTWNyoazg==
X-Received: by 2002:a17:902:f68c:b0:25c:d4b6:f119 with SMTP id d9443c01a7336-290c9c89ce1mr445488005ad.12.1761453846681;
        Sat, 25 Oct 2025 21:44:06 -0700 (PDT)
Received: from localhost.localdomain ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm39315755ad.48.2025.10.25.21.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:44:06 -0700 (PDT)
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
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v3 1/2] PCI/aer_inject: Convert inject_lock to raw_spinlock_t
Date: Sun, 26 Oct 2025 04:43:34 +0000
Message-ID: <20251026044335.19049-3-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AER injection path may run in forced-threaded interrupt context
under PREEMPT_RT while holding the lock with IRQs disabled.

On RT kernels, spinlocks are converted into rt_spinlocks, which may
sleep. Sleeping is not permitted in IRQ-off sections, so this may
trigger lockdep warnings such as "Invalid wait context" in [1].

  raw_spin_lock_irqsave(&pci_lock);
      ↓
  rt_spin_lock(&inject_lock);  <-- not allowed

Switching inject_lock to raw_spinlock_t preserves non-sleeping locking
semantics and avoids the warning when running with PREEMPT_RT enabled.

The list protected by this lock is bounded and only used for debugging
purposes, so using a raw spinlock will not cause unbounded latencies.

[1] https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 91acc7b17f68..c8d65bfb10ff 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -72,7 +72,7 @@ static LIST_HEAD(einjected);
 static LIST_HEAD(pci_bus_ops_list);
 
 /* Protect einjected and pci_bus_ops_list */
-static DEFINE_SPINLOCK(inject_lock);
+static DEFINE_RAW_SPINLOCK(inject_lock);
 
 static void aer_error_init(struct aer_error *err, u32 domain,
 			   unsigned int bus, unsigned int devfn,
@@ -126,12 +126,12 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
 	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	bus_ops = list_first_entry_or_null(&pci_bus_ops_list,
 					   struct pci_bus_ops, list);
 	if (bus_ops)
 		list_del(&bus_ops->list);
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	return bus_ops;
 }
 
@@ -223,7 +223,7 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 	int domain;
 	int rv;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	if (size != sizeof(u32))
 		goto out;
 	domain = pci_domain_nr(bus);
@@ -236,12 +236,12 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 	sim = find_pci_config_dword(err, where, NULL);
 	if (sim) {
 		*val = *sim;
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
 out:
 	rv = aer_inj_read(bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
 
@@ -255,7 +255,7 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 	int domain;
 	int rv;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	if (size != sizeof(u32))
 		goto out;
 	domain = pci_domain_nr(bus);
@@ -271,12 +271,12 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 			*sim ^= val;
 		else
 			*sim = val;
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
 out:
 	rv = aer_inj_write(bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
 
@@ -304,14 +304,14 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	if (!bus_ops)
 		return -ENOMEM;
 	ops = pci_bus_set_ops(bus, &aer_inj_pci_ops);
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	if (ops == &aer_inj_pci_ops)
 		goto out;
 	pci_bus_ops_init(bus_ops, bus, ops);
 	list_add(&bus_ops->list, &pci_bus_ops_list);
 	bus_ops = NULL;
 out:
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	kfree(bus_ops);
 	return 0;
 }
@@ -383,7 +383,7 @@ static int aer_inject(struct aer_error_inj *einj)
 				       uncor_mask);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 
 	err = __find_aer_error_by_dev(dev);
 	if (!err) {
@@ -404,14 +404,14 @@ static int aer_inject(struct aer_error_inj *einj)
 	    !(einj->cor_status & ~cor_mask)) {
 		ret = -EINVAL;
 		pci_warn(dev, "The correctable error(s) is masked by device\n");
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
 	if (!aer_mask_override && einj->uncor_status &&
 	    !(einj->uncor_status & ~uncor_mask)) {
 		ret = -EINVAL;
 		pci_warn(dev, "The uncorrectable error(s) is masked by device\n");
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
 
@@ -445,7 +445,7 @@ static int aer_inject(struct aer_error_inj *einj)
 		rperr->source_id &= 0x0000ffff;
 		rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 
 	if (aer_mask_override) {
 		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
-- 
2.43.0

