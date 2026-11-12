Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470083;
	b=N4glBis5+X6Hhgdn95KgYbf5QLz41EtX+mliQXiWgd7V6QcT8dwWG7fTF4FVKAoNE/pd
	 9G9Cec1XuulRj/AUXQgZJDCMX+ID4HOSl/TvtFYUSQF+vWL0pZ3lJRbOzsQn0g+BWdn+Q
	 2YOm9iX7FaCdJwWB1b0NhbFA9BXd86Aj+m7l4Zgk+LK3T8piwEByV34QxyzeD2YwtLvll
	 oiAyaoOQDVZO0fQTDuE4VaCiXbjQ4Vms+XX5WPsyxPCIjRHYDb92Pa5hA8DstMCnv2kix
	 QZv1HNZtrQVdV8MX2mhE22rop6Lbnl0AqOQILL9tZenz1IMZa6AMjbBnRL9ui4IcMYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470083;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xGL/HNVqvS5d5VECAcbldccQrTuARuH0rtmRBd+1lJY=;
	b=jSQQPtYJpkqzFTjpM9jA354jD/k8PM/vqUvmks7HEMAQ2JNv7869PhYo8aejbSwVvzIU
	 Pi+0mRtoxvKSCehmxcIRqaVLthl1d6bNIEVy/krZ7jaIG5xefea9VI0bpFGhs2H5JJTRO
	 tlyhf/K+KWsfFVZYFwQY3t09+uT3L3jGqH0VoJ0jZtTh3c9EwY6EUR4x9M5AcRpzpKwEw
	 MDNd/RVsipRW2nDFSSCIesrxmBiyfeUTJaJvJZIUhUrI0GIm4YZSVHQThhN/17fy7cbn6
	 yOZvMBkAT8mNiTil68qm8UycO9K9k3GOzrGoP5KkFhjqhymL4mUYVnUbHiTLCPF7VIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gCeQCAUq;
	arc=none smtp.remote-ip=95.215.58.74
Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6E606A321
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 07:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D6E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gCeQCAUq
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=+64NsR6ul3OZ/C2gNEoQRkSF05SWBVdC/PV5wsbpHBI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794470080; v=1; x=1795074880;
 b=gCeQCAUqrK9rD27CpGVLGtePt+9dgReeb/a0KsLnvGEV0B+bLM871z7QXVooQb7tijXQs4Ps
 gCMMlLIpnMeyp8Q0BfiH226MyZix3eFkaGEoB+W3KW8HiDr6jhXrxGoBnY6XRK6jEL1EIqZHUB9
 s7IZx3iFYq/rz8E8/i0b/bXQ=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 149ddc421f06301b;
	Thu, 12 Nov 2026 07:54:40 +0000
X-Mizu-Trace-ID: 149ddc421f06301b
X-Migadu-Flow: FLOW_OUT
From: Troy Mitchell <troy.mitchell@linux.dev>
Subject: [PATCH v2 0/2] irqchip/riscv-imsic: Synchronize remote state with
 IRQ work
Date: Thu, 12 Nov 2026 07:54:31 +0000
Message-Id: <20261112-imsic-remote-sync-irqwork-v2-0-680f65b24ff6@linux.dev>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dgytQsSV9zAsYBhkVFqdQoUQ7
 i7gBVy+5P33J+VJmLw6R5MSCuzZ2QXMLlLYFPZGwNXCysQm1To+ALeeEYRa1xH40SKwvD9OHpB
 hTZjiUccVqWX/Eqp52NrX/Me+L++E3RpcjYZ952TczoNevX9+ggYNpzLBLNE1pqa4PNn2w76io
 PJ5nr+1GDbq1AAAAA==
X-Change-ID: 20261103-imsic-remote-sync-irqwork-9cfec6c410de
To: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978;
 i=troy.mitchell@linux.dev; h=from:subject:message-id;
 bh=+64NsR6ul3OZ/C2gNEoQRkSF05SWBVdC/PV5wsbpHBI=;
 b=owGbwMvMwCU2g/N9w09jE33G02pJDFlfC3Z2yDi8s/mQfCX9haPbr5++Z2Mavr0NWrxhD59t/
 arZqxz9OkpZGMS4GGTFFFm6H/BsK/CJsi0QKPSFmcPKBDKEgYtTACZiFsrwz+ao57trPa8emWn/
 vM0c9+8pU11n8fI8R25ze8fr27+aazL80/p8rV5vrcns7/cvxq7yfNCl42EeYxm61HGyy/QLe+I
 s+AE=
X-Developer-Key: i=troy.mitchell@linux.dev; a=openpgp;
 fpr=3FE5535CF1B0E658E57DB59BAE1C2FBEA7DB42E1

This was found while bringing up the SoC timer on SpacemiT K3 as a tick
broadcast device.

Without a real broadcast device, the tick code falls back to the hrtimer
based broadcast, which keeps one CPU's local timer running. Once the SoC
timer is registered it replaces the hrtimer broadcast, and every CPU may
stop its local timer in idle.

On K3 the SoC timer interrupt goes through APLIC in MSI mode to IMSIC.
When the CPU owning it goes offline, the interrupt is moved to a CPU
that may already be idle with its local timer stopped. IMSIC leaves the
enable on the new target to a timer on that CPU, and that timer can only
fire through the broadcast interrupt, which is not enabled yet. The
system stalls.

Patch 1 makes remote synchronization use hard IRQ work, which fixes the
stall.

A vector move can still take long to finish. The CPU entering idle
takes over the broadcast interrupt and syncs the new vector before the
old CPU has released the old one, so it arms a retry timer on itself
with its tick already stopped. The move then completes only on its next
interrupt, up to 0.5s later on an idle K3, and affinity changes of the
IRQ return -EBUSY until then. Patch 2 lets the old CPU kick the new CPU
instead and removes the retry timer.

---
Changes in v2:
- Patch 1 unchanged.
- New patch 2: once the old CPU has released the old vector it queues the
  sync work on the new CPU, which then completes the move from its own
  IRQ work. The per-CPU retry timer is dropped, since a move that has to
  wait for the old CPU could only complete on an interrupt driven by a
  timer that may itself be stopped.
- Link to v1: https://patch.msgid.link/20261103-imsic-remote-sync-irqwork-v1-1-8b5c951fc62a@linux.dev

To: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>
To: Anup Patel <anup@brainfault.org>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Björn Töpel <bjorn@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-rt-devel@lists.linux.dev

---
Troy Mitchell (2):
      irqchip/riscv-imsic: Synchronize remote state with IRQ work
      irqchip/riscv-imsic: Complete vector moves without a timer

 drivers/irqchip/Kconfig                 |  1 +
 drivers/irqchip/irq-riscv-imsic-early.c |  5 +-
 drivers/irqchip/irq-riscv-imsic-state.c | 87 ++++++++++++++-------------------
 drivers/irqchip/irq-riscv-imsic-state.h |  6 +--
 4 files changed, 42 insertions(+), 57 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-imsic-remote-sync-irqwork-9cfec6c410de

Best regards,
--  
Troy Mitchell <troy.mitchell@linux.dev>

