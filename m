Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510761;
	b=JhAiscP2Kf4P8PgqMHE+6BJXd9JD7+IlThpiDWu7QL/FyKk8+m5W2uIhaKU7iobVad8R
	 KJ0KaCs8ukv6+zafi4bfErXBxJn+ztIJzJj1qjA0PFe4FihdsCnLdgeWT0TvrZZOqwPwN
	 kXok1xwF0Lmu4w/mS3NCNncykIb7fjmsMcuimmj1y3/Ve0JlVWyaRZQGIt4G1ss8bdNtl
	 +d2v5y12h+OqpNoO9ysWUo/hPnam0g0ssgUjXqVNv2UGwviLxC8+TWPtojGXfVMZGllcS
	 TNw2nR6CJ/AtTEoH1I+7awbZjJzmcPlEkaHdJhwpKki/P34Lchv8yapkpu5T6qwYddw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510761;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=xy84/OhUdkEAmgWQhwV2cjivXNZVLIDniNQi91s3WhY=;
	b=S372ZoKu5OqT9UQ1dPqeH/4faERq+Kx4sLfA0kmFjnMGAt47F/lMHno5xe+4xjHxO5x8
	 KSeOoS03ssH4ZdSBiT8Ea/kMZX+CS64nkt65pJ/CEXoYSKZ1uWr/jQbRU/hGghRI8T8vt
	 UoFOgIOcQi69BHMtZcDSVfMrtbx3vmEtvxIiUuXtGoXwQUaKl8H+Vk0EIP4srv7jC58yT
	 whlaYPlmlIzjCmC/lL9PmYYi3ZVWnyXXrsVoe7mVSCr9oVKjoTPP1zvlAk2vboLforN6R
	 sqE1stX6opzrRlSFJsxyh8KZpxYFx1rO3RLFeF45hNTmdWWjChw5dbmLMOlDjHvSBbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FD360A260A
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 15:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62FD360A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1792510758; x=1824046758;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gYKX22JJXvjBQaFR9/tw6kVOEs7CPr0eQzlXEVHWhAM=;
  b=jVr+CoCWVzqlbwN+spOj2RC3lYhFKDy/He2IoGFHSNi8vdvYpCD0kkIe
   NozHvBTdQ3lXoqU3OwWUuDIDRtubGPt8c7vFyJDhqHb0Q2iUfg0lhMdlk
   HFx0M/1aG8PwuvYdWJBuCP4MBbkuOA1w1xLA4M9hYL3vFlSnx7g0mLj88
   tfDGuKkRa9K3e5ilt+q8aNV1aVFbpXQs1qXKCMs7uihUTB/nDd5Wzzmdz
   40/9iewjhOA/F3c3gtoxY6WDdfftpe3+PzrMAUgR7nGRemRmKEECTPXsQ
   puZSWypbwPUd8R2/ZbvninxNn89X3E7g2fAgwMGvtDvNBYPra0YDI13/T
   A==;
X-CSE-ConnectionGUID: zFJkn98zTLuN0wnQwqjKdQ==
X-CSE-MsgGUID: gkjUJ1/pS3SxtrLCXJcJOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 18:39:13 +0300
X-CSE-ConnectionGUID: AoT8UrKGTraFis5HMcQdyQ==
X-CSE-MsgGUID: wgiBKU4qQAuY5JlkNLQL6g==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 20 Oct 2026 18:46:49 +0300
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 20 Oct 2026 18:39:12 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Tue, 20 Oct 2026 18:38:49 +0300
Subject: [PATCH v5 2/2] irqchip/riscv-aplic: force synchronous probing
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-aplic-async-probe-v5-2-c4861c2aafca@mobileye.com>
References: <20261020-aplic-async-probe-v5-0-c4861c2aafca@mobileye.com>
In-Reply-To: <20261020-aplic-async-probe-v5-0-c4861c2aafca@mobileye.com>
To: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Jessica Liu <liu.xuemei1@zte.com.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

The APLIC driver leaves probe_type unset, so it follows
PROBE_DEFAULT_STRATEGY and is probed asynchronously when the command line
requests it (driver_async_probe=). The probe of an APLIC instance updates
state shared by all instances without any locking:

- the check-then-set of aplic_syscore_registered; two instances can both
  observe it as false and both call register_syscore(), inserting the same
  list node twice and tripping CHECK_DATA_CORRUPTION ("list_add double
  add") in __list_add_valid_or_report();
- the global aplics list, modified by aplic_pm_add()/aplic_pm_remove();
- aplic_direct_parent_irq, where more than one instance can pass the check
  and register its own CPU hotplug state;

Interrupt controllers are required early and have no benefit from
parallel probing, so rather than adding locks around each of them mark the
driver PROBE_FORCE_SYNCHRONOUS. Probes then run one after another from
driver registration, and deferred probe retries are serialized by the
single deferred probe work item, so the shared state is never accessed
concurrently. Probing is also blocked across suspend, so it cannot overlap
with the syscore callbacks either.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 drivers/irqchip/irq-riscv-aplic-main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 5369078f3d00..3c10dbf3b492 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -118,7 +118,8 @@ static struct syscore aplic_syscore = {
 
 /*
  * Not __ro_after_init: probe can be deferred (e.g. MSI mode waiting for the
- * IMSIC) and complete after the init memory is made read-only.
+ * IMSIC) and complete after the init memory is made read-only. Probing is
+ * synchronous (see aplic_driver), so no further serialization is needed.
  */
 static bool aplic_syscore_registered;
 
@@ -413,6 +414,12 @@ static struct platform_driver aplic_driver = {
 		.name		= "riscv-aplic",
 		.of_match_table	= aplic_match,
 		.acpi_match_table = ACPI_PTR(aplic_acpi_match),
+		/*
+		 * Probes of multiple APLIC instances share global state (the
+		 * syscore registration and the parent interrupt of the
+		 * direct mode) and must not run concurrently.
+		 */
+		.probe_type	= PROBE_FORCE_SYNCHRONOUS,
 	},
 	.probe = aplic_probe,
 };

-- 
2.43.0

