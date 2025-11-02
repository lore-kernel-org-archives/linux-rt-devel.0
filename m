Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566C26B742
	for <linux-rt-devel@lists.linux.dev>; Sun,  2 Nov 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081091; cv=none; b=bFteDYdmv8Aq7TkA+1THmPScbIFGdVlnTFaz5UxFS03blVspeVozgBEruoy7BE9uLBXdoZfWOGwJ9YhaN92hd/6LD9nXShnI1fSwY0jOrneFlVObQGvjYQJmSOqo3L//bOukAsodpgXBeNVfLc4kPh5S3OKpwNEO8DSx+PV8bCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081091; c=relaxed/simple;
	bh=iU945rxIytYge2u36qpKv+Z6kWAP0ds/jXgSSHdC0x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rD4jci7R83uAkQVkRkJBI2ixD15WM2tajMZrvoZoecp2r3dzxiBlwDuQXHsJPNHTMclJzm2vC6cMeCo28jV8Z2sC3fUhOoerV/sFVKWQrjUYsMokBiuIG/VKCIo62A5pPVNc7vcOuOXzQ7g/SLqM3Xa4s4MiP0EqXkGDCcPHIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaLfwQMn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaLfwQMn"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso2661060a12.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 02 Nov 2025 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762081087; x=1762685887; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnvxcwW4nROqi/pUDVHqj/B8lAE5wjrS3W1SNd+wzqE=;
        b=OaLfwQMnjdXKPTQFQP3/6yCb9FtE7Pf7rCoCLVNGAPFxdhDgIeUsj/GDFn1klvLDHE
         zBGYKPoq5xnnHtwX+pjSa9dX6N5i6ReT9zcoyg9jiwSjO0f9UGnRYJ4KK2eGAnXcOX85
         Y8wRXF3nZO6cSXpCShpAaabemfBAb/jU0r4L4N+M+tN2gug5L/6T9RmSAnLpx+flN5br
         zilY4lmrByLWbuHb5cyCtfBlg+reIzZ9NNSZKDb7c8X/wt7FpHQ32VCejpZmRL0QJDJG
         ZfwEiEzErhY3VLI/9d8pBzwsDM27/3+94OBTeFESGg+LC+8o2GIgY5GjbhnXiT4d75J/
         Q/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081087; x=1762685887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnvxcwW4nROqi/pUDVHqj/B8lAE5wjrS3W1SNd+wzqE=;
        b=Bf6Wg8mRSFC+VRIKMHYnkeI6xCHobiNFotAwGU7hKkqgknAL1QCdUn/XrC/g4gEcjd
         S8fKxbmx3bKHw2YJGG5AB64bNXtuiXnVc+WsvxukrrruU0yeM51T3f7iP87U1WNbu6oG
         huOGOuvG+TF0GcPewwttt0LWZtdTKBwsznupAwFHf81UQMQsFk5U93zbEX86hfGLj2CX
         bne3UyklP5g3TtxGRRQjg0jreE1FqfUMXObpXleQl374VXHix7EFMBWGxNmCBxaMW3j8
         mES4GQAsccogFgSG7hBH1+zLfhf/zNS93znbU+ZJBJdS26GnHF0tHv/BW2E86XhwTtxS
         33RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoPnfzXOdt65RidcZwYTkl60qFsFAkIRopMEU6McMDF26o0m9TPK4X9885B3GH+QmRlQAXfQ6wxho8dM+4vg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQMVYiH/8bGP0ajdN1GEXh4tihVTOsqE0BQOGldziPDuUnnMon
	eDMNd0PeTK3iuLzUCw1fY6v95JN1WtT4eakForIQ3eorLrXNAS1dSPuj
X-Gm-Gg: ASbGncuFEVgaTVbnMNbtF/AJXeeD6j0KIO1xNXtNHyD8lAZeuSvutpiqgGcJldfVngX
	UTdDy+c94mmQ2hSG6/RY5jraNCqZ9Jm5YDrMnpw6xVNkK806TbvtWDrptpD54MZgdhVVIuwRf4w
	B0D5kBQwVhQeAhybCDb89RlI4RL71bHPcH4KKN8jcwNF6A7CYMGHNhk05qcfA7GxQq1dvGlfw1g
	BQFOFnlfyMdNlV7sLmtbg+qE25/Ru4H0V2E88G+HraIAsDSeORd7Ef7LIj06dmuO+bYiNqcQg9A
	kRw6arR9hNGqP2+FQ8mxUgN1/+kbKxVAXEwaFBnqF+jzIhWYtofgiNH/MXyguqIeBAqdmkv/R3J
	26IxxcqVIcgfvhLHO287OhVy9D5UrbUIi7Wq7xbYjOtYEqz+9thB9EXnNyhyrzfmu//07HpcDSt
	hXvwdUfxX7+nngpdZtu72+yCwYPnkkKOhV5Q6sL5z/YT+raV3NEQ==
X-Google-Smtp-Source: AGHT+IFw7LQmxvnT7Z6/GWYHHWlCaXIwYo97IH5BaRo8+IRI9C+4EfgykCBDqZa3hOGXe79E1lknOQ==
X-Received: by 2002:a05:6a21:99a1:b0:340:a205:681a with SMTP id adf61e73a8af0-348ca75c051mr11435936637.4.1762081087211;
        Sun, 02 Nov 2025 02:58:07 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67999bsm7488050b3a.56.2025.11.02.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:58:06 -0800 (PST)
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
Subject: [PATCH v4 2/2] PCI/aer_inject: Convert inject_lock to raw_spinlock_t
Date: Sun,  2 Nov 2025 10:57:06 +0000
Message-ID: <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AER injection path may run in interrupt-disabled context while
holding inject_lock. On PREEMPT_RT kernels, spinlock_t becomes a
sleeping lock, so it must not be taken while a raw_spinlock_t is held.
Doing so violates lock ordering rules and trigger lockdep reports
such as “Invalid wait context”.

Convert inject_lock to raw_spinlock_t to ensure non-sleeping locking
semantics. The protected list is bounded and used only for debugging,
so raw locking will not cause latency issues.

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index d0cabfc04d48..a064fa2acb94 100644
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

