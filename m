Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510758;
	b=NZSWK429YjO/6I0SCsPaHFx71cqLAkbUlAwSGjpk0yTZnlJZuBx67MWks2nxjSZguQ5A
	 neB22ZSiRaO7tNZDmjLY+72iAwK+uvoAFvbm5fqpXhfdma+FXMSNnfHuUUi5SjLKXp2US
	 NmiAoKLI4Xr+atwsVfBlkFAD6tX2I+9jQ5GLvPHM0CzSIEHVuWLowuDztZOZht930j2xf
	 0DShr4NMuRmUA7P09WXaNFoHXHRMIOiqntQl/13GsKoox8gbbN1CHE9moR8gShLeYNpPh
	 cg6pKll3ztzNH0OZowkZIM2Kr7QG4Ms/dZGyibnAV+fniR4F72tgveFPM4c/XvLNofg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510758;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=IEpug45/RgWjFt69iJGqq4fHXGRjLFvT4L4JSGopD8w=;
	b=q9Qy8UjRN5j3wZpGioJ/sVdr8oTvqt4T9PjrrR5FgopTmaLJ4QtHcv5lxgecYPfz2mmG
	 r19Xtq2WED8N4msOazLu4nR+DXp7SwTwOvjbeR6gYCzsb4BV0P48uJqGC7A7kI6ca/hn1
	 52vTKcD/G7V+5O7zMepPrFXEPaUqIMCuesRyz+w+0UjBOvDlodcN5bx2D0m6KyfccRJdY
	 h6Q8u+HECwwCF2kXUIWaLhNE/4w+CucG9JZJAHGgJ+dD4Z/0qw5YSLDOxKvVNoOLd6b/r
	 aeeL19pQgumIbnz+ER40xKFx+hYtpad4pMW8Grr+uLF6PnPBILiSCpakPu6SR8ZwGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D116C606A33D
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 15:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D116C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1792510755; x=1824046755;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ZKlMgO+Am7f1W6tqLYmCFZtZZ52fpO6WIVEULY/+2O0=;
  b=bEBOmrrv+aGr+RTAc9hV/a1bAWHwCiJvZ9XAiXrQZa0zzmHh0P1jiBJd
   qKY0vhbd10M7OHsBfPB5Dd3eMHJ6YMRQU6rOXMRUtF4jGZrFOjD49HlJp
   lFdbdAMUE3E1U0v+6F1wVSDsXnGdQhxWLHusZjsy/lnPnloyWbo7yRVx1
   CLIoCAbamA9Hmq2moo4MPFcRZC6W2A3ANCVpU1rscIaLidgjsZxT6extj
   lNh+Lw+8MGmD4r1pIPHv1WIZB9yHFy2XGe40aarQ7DdyvjZcZ7Y7na75C
   gMdiPu0RV5IeIP5HlMMWuxZmbzLaPlP2cGdUatUo3/IYD3KWFuwFR374Y
   A==;
X-CSE-ConnectionGUID: zFJkn98zTLuN0wnQwqjKdQ==
X-CSE-MsgGUID: l1/GtodyRWeOGRgM9rJKog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 18:39:12 +0300
X-CSE-ConnectionGUID: mjGPr9p4QrO3rL/VA25XsA==
X-CSE-MsgGUID: W6NDLE3XSNefvPhNS9vl+w==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 20 Oct 2026 18:46:47 +0300
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 20 Oct 2026 18:39:10 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: [PATCH v5 0/2] irqchip/riscv-aplic: fix probing of multiple APLIC
 instances
Date: Tue, 20 Oct 2026 18:38:47 +0300
Message-Id: <20261020-aplic-async-probe-v5-0-c4861c2aafca@mobileye.com>
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
X-B4-Tracking: v=1; b=H4sIAAeL12oC/4XNQQ6CMBCF4auQrq1ph7YUV97DuIBhkCZISWuIx
 HB3KytjiCz/l8w3LxYpOIrslL1YoMlF54cU+pAx7KrhRtw1qRkIMFJI4NXYO+RVnAfkY/A1cSs
 NKBK5NqJg6W4M1Lrnal6uqTsXHz7M64tJftZ/2iS55AoBVatrUUpzvvva9TTTEf2dfcAJdhFIi
 DW2KYxVWDZbSL6L5AnR2GpoEKwpxQaivhAQW4hKiLE15poEIckfZFmWNxSqcgCEAQAA
X-Change-ID: 20261012-aplic-async-probe-81624e035607
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

The APLIC driver does not set probe_type, so it follows
PROBE_DEFAULT_STRATEGY and gets probed asynchronously when the command
line asks for it (driver_async_probe=). The probe path of an APLIC
instance modifies state shared by all instances without any locking,
for example the registration of the syscore operations. On a system with
several APLIC instances this triggers a "list_add double add" report from
CHECK_DATA_CORRUPTION, because two instances both call register_syscore()
for the same node.

Looking at the problem showed a second, unrelated issue: the flag guarding
the syscore registration is marked __ro_after_init, but with MSI the probe
can be deferred until the IMSIC is available, and then writes the flag
after init memory was made read-only.

Patch 1 fixes the latter and is independent of asynchronous probing.

Patch 2 marks the driver PROBE_FORCE_SYNCHRONOUS. The shared state also
includes the global aplics list, aplic_direct_parent_irq (together with
the CPU hotplug state registered for it) and the per-CPU IDC structures,
so making probes mutually exclusive is simpler and less error-prone than
adding a lock for each of them. An interrupt controller is needed early
and gains nothing from probing in parallel.

Reproduced by booting with "driver_async_probe=riscv-aplic" on the
not yet upstreamed "Mobileye eyeq7h" platform with 3 APLIC instances.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
Changes in v5:
- split the __ro_after_init fix out into its own patch
- drop atomic_t/atomic_cmpxchg() for the registration flag
- mark the driver PROBE_FORCE_SYNCHRONOUS instead of protecting each piece
  of shared state separately
- Link to v4: https://patch.msgid.link/20261020-aplic-async-probe-v4-1-68bc35e0ece1@mobileye.com

Changes in v4:
- rework commit message
- rebase onto v7.3
- Link to v3: https://lore.kernel.org/r/20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com

Changes in v3:
- drop __ro_after_init attribute due to write to read-only page concern
- Link to v2: https://lore.kernel.org/r/20261012-aplic-async-probe-v2-1-868d7684c9d6@mobileye.com

Changes in v2:
- fixed potential access to read-only page
- Link to v1: https://lore.kernel.org/r/20261012-aplic-async-probe-v1-1-4c2c4f5b0916@mobileye.com

To: Anup Patel <anup@brainfault.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Jessica Liu <liu.xuemei1@zte.com.cn>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---
Vladimir Kondratiev (2):
      irqchip/riscv-aplic: do not mark the syscore registered flag ro_after_init
      irqchip/riscv-aplic: force synchronous probing

 drivers/irqchip/irq-riscv-aplic-main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261012-aplic-async-probe-81624e035607

Best regards,
--  
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

