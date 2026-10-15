Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F6326945
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028053; cv=none; b=oKwvQYhYStydtjBRkq1MbGDNJGyVd3Fnd5Hbx/D/zZHAh7sYDzW/twrIc0VcBiYe/RNjr0ObWc6Ea4iaunQxoNnV/mYPFSp64l1VXydFW/LFrQbUEe070JTM1F8AfGlTqO6N0jqaFjH/5HF0XgIMknjM3D5nJ2ot7cWIybwUi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028053; c=relaxed/simple;
	bh=4CvRGIp6BIsaGEZIJnQQcG8VduybJepsrgAiyhMNK3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TJo929B44jXlws/CcXFo7d8LQMxdeiKWlDSGfPfajeX44k+bOp5+rnGDN7MRSBYlnMcFLbXRy6DxNADvwkzrSVZ22y9/kLGyXSBp6YSUg1D0ri8g7GWrH0n0gjWVu2c8CPvb8skvL0+S8BcsXbmIvF8ls7pmcUl+KHDmzMMNXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD76bWMJ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD76bWMJ"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-483c607ccb4so622819fac.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 18:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028049; x=1792632849; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jI+Ive4AxdeL0phc/iy7IBSWWLYJLEaf4nq97ulSuEE=;
        b=AD76bWMJqFqbgyNEvkO1O1zcNdHuMY/AEeke20kK41sfFzXHScGHR5gOu1jwSwfPYq
         SgabwL5nAHxvisYp7d4l/EkGTXootqx3fFJ2kFoD0oJSPHgFZKtHURLRUDjfd8dAYnPJ
         8VB4aniUth96h6qOFVNm3RC1HrTwOgbocjyYLF4CmHCmNWXh9WeIVEwu6JWhio6MfH6v
         8lvh7Jb8msB6kV1as9FJhJ5R4k0s+k/1ZyGaj+NsqCXyWhBg51Jq5qClNqMEm6vpEi+I
         kEpAJEF0srEzC05vSpNbX1TRh/WzW0y2KcNHB52jv+6v9cnIzhrV+GXd8Ujl6W7oipWd
         C94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028049; x=1792632849;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jI+Ive4AxdeL0phc/iy7IBSWWLYJLEaf4nq97ulSuEE=;
        b=arNQnFlk2cn/7KzsCRe4gsHAZG/pRqwic3Bn/64+RxtXTfysLrODUdaWcEKLuY5arb
         myHyxhKqPWXZSe2/ezeq072rFy8LG6uxJBru9S7xStAINyVFtIAbGIL4lsXrqrMql7vC
         1o6j6/+4h+qQv7CToiO4+19RmAGHfd5a51jU9NwdOjYDJYr79BEfAXGHSNe9oapOAg/Y
         J+DwNcYsZiI7Vg9iwVxccqb0u1B52MJakpTAJ1TdtrLLLiana4IMxgtMutCldfqyl8hM
         hL8yotcy9mFpaUGOeLEqHtZUyhcCihq4rS8QIEyd3uZwS7uXUcLxKsWtmeM3b7S66zsO
         Hvew==
X-Forwarded-Encrypted: i=1; AKwUvBxUehgvIHWPm4/W8MQ4WrFHbFKKWmVMWxOEfW/0iGybMBeUx/J3sRCwQGQynBrkfRMy1iHZyMI1mrLShBjK/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKWpoku9J++iFReHW012OnULg3NbFpOXz+0QBWb2AkT8L9J0zqO
	p+FrKAx0dX+3aF6WHzxuy2ueX+UkjUtyuy9QPWoPBHvYOnffl0orIje6
X-Gm-Gg: AYBFou1nWY/XgEtF/h6r9fRUBI1wj1lr48o9n6XY7o1rGxaFhnYxu1CqzCHV3ODFB+6
	NCrznZL44As5DCVOiXZQ8qAeMVug4i6OrnZZRZ38GMI4ghK7LVOf09VJTZaKaAO2sYBzk67YIBV
	M1iycsxAR9xmK3hBvEdkSPfkYSoKXOLhgRrnVki48o9oXtH1b4vd9Z3grJXoczP1O5ISSX/QFwc
	GO+QgQb69sAFx4ExM+OezaGRwNzLEC7goIao8Sl6Df66UaFf2qNxIitARgH/BusEiXwEW2oZbx7
	P9iatKLHxbJ8toBYjUmU6cnDnuUFvmqWO0IW/Lbz1gmOecLxSkdKKEcuFQk4EDzTrOT7JqLkfCk
	BLjMGovWjdjRPTsTaoCfHyb0D7Q4S78MOpDDBZOcp6IMzZaeAKinVKBFuuDY6MEOMVfWSm6QjKs
	ZPoJwZ+1nWstu7ZrIQzp/4g3HL6NVbBo1SbDkaCanPmrSqp4CuOXkhZ2RKXH94Ommde2BtgWDkH
	LYmep0i6+5Vx91hGqgdqMnAkVHlOZs0NGu88iz7Gi8BmCsmBr3DaSYyqeR55kA8SSd/qrZukHSU
	RjMrZc/p4VmbWodfF6Ca2wU2C8v9oqV7h8HQgGCXFlcXWwMd4i4Iob+SJuZVAx1UUsoTFovS8nR
	1v8p2tj/iUqzHn71Mdyf8
X-Received: by 2002:a05:6870:b2d0:b0:493:7742:f0f7 with SMTP id 586e51a60fabf-4a2a896b22bmr15664913fac.11.1792028049365;
        Wed, 14 Oct 2026 18:34:09 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb41452sm3428139fac.4.2026.10.14.18.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:34:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v7 00/16] mtd: rawnand: sunxi: fix transfers and support
 randomized OOB
Date: Wed, 14 Oct 2026 19:33:47 -0600
Message-Id: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XQTWrDMBAF4KsErasyI40lO6veo3ShPycqsVRsx
 yQE371yuqipNy4IxIPhm+E92BD6GAZ2PDxYH6Y4xJxK0C8H5s4mnQKPvmQmQCioEfhwtV0cy5d
 ukSeTPJ9C8rnnOVt+Mfd8HfmEPEhE8gjONY4V7KsPbbw9F71//OQifQY3LvoycY7DmPv785IJl
 7l/Ly0POClZV9IgGd+8nToTL68ud2xZOolftgHazYrCWhSgqSXjjP7LyjXb7GZlYWtZOwvWYEU
 bllYsit0sLSUYRTb4hoTYlFCtWbmbrQqrvUYErYxqN9eqNbu/W1VY0VqoqQ2gK1yz8zx/A8liD
 TGhAgAA
X-Change-ID: 20260810-submit-sunxi-nand-vendor-oob-layout-v1-e3114d10cc9c
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2

Patches 1-14 address the existing driver independently of the Allwinner
randomized-OOB format in patches 15-16. Please review and apply that prefix
regardless of whether the format extension is accepted. It preserves the
existing on-flash ECC geometry, bad-block-marker representation and raw
callbacks.

Patch 1 centralizes OOB handling without changing behavior. Patches 2-10
fix logical-step lengths, read and write error handling, completion reuse,
pattern-ID selection, duplicate program confirms, small-page read commands
and the H6/H616 user-data register limit. Patches 11-14 then reduce repeated
status reads, column changes, chip setup and length-register accesses.
The pattern-ID fix precedes status caching so correctness can be reviewed
before the register-access optimization.

Here, "user data" means ECC-protected metadata in OOB, not the page's main
data. PIO reuses hardware slot zero for each logical ECC step; DMA can
transfer several steps at once. The patches distinguish logical steps,
hardware slots and packed register offsets, and explain their triggering
conditions independently of the format work that prompted the review.

The IRQ fix retains timeout-only disable_irq() and explains both the
forced-threaded PREEMPT_RT race and the unbounded cleanup/no-priority-
inheritance tradeoff. The small-page fix is limited to read-side
repositioning within existing geometry restrictions. DMA batching preserves
the installed OOB layout rather than capping its allocation.

For devices provisioned with the Allwinner normal-page format, support is
required compatibility with existing flash contents, not a preference for
another layout. Its bad-block marker is randomized: applying the existing
plain-marker compensation can make normal OOB reads and bad-block scans
interpret good blocks as bad. Switching formats is not a transparent
kernel upgrade.

Patch 15 documents the opt-in binding; patch 16 implements the format
through separate OOB callbacks and an attach helper. Its geometry,
page-wide classification and contiguous parity reads stay together.
Without the property, existing format selection and callbacks are unchanged.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Changes in v7:
- Put a behavior-preserving OOB refactor first, the correctness fixes next,
  register-access optimizations after them, and the binding and Allwinner
  format last. Keep 16 patches with no external prerequisites.
- Keep logical-step length, read recovery, IRQ lifetime, write failures,
  pattern IDs and DMA limits independently reviewable. Correct pattern-ID
  selection before introducing per-transfer status caching.
- Update both DMA callers with the protected-OOB helper contract in the
  logical-step length fix, before the later batching change.
- Isolate format policy behind its own callbacks and one opt-in attach
  path. Fold packed H6/H616 geometry and contiguous parity reads into the
  final patch, leaving existing format callbacks unchanged.
- Use scrambled_plain_bbm_oob for the existing scrambled profile and
  allwinner_oob for the firmware profile. Keep shared randomizer helpers
  generic and name the H6-generation spare predicate after H6.
- Clarify protected-OOB terminology, logical/hardware indices, transfer
  failures and the limited small-page read scope. Explain the RT timeout
  mechanism and disable_irq() tradeoff discussed with Miquel Raynal.
- Explain installed-format compatibility and that the spare check re-encodes
  ECC-decoded protected OOB rather than rereading physical bytes.
- Drop the standalone OOB-helper renaming cleanup and explicit stable Cc
  trailers; retain Fixes tags and Conor Dooley's binding Acked-by.
- Rebase onto current MTD nand/next.
- Link to v6: https://patch.msgid.link/20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com

Changes in v6:
- retain the bank-sized first DMA batch, but transfer later logical steps
  individually to avoid PAGE_OP's absolute internally generated main columns
- keep ECC exception mode enabled for randomized reads on all supported
  controllers, using the shared physical-pattern classifier
- classify uniform-pattern steps even when hardware suppresses their ECC
  errors; skip their correction counters and preserve decoded buffers unless
  the page-wide zero override or vendor spare predicate accepts the page
- Link to v5: https://patch.msgid.link/20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-0-7d711076a6f7@gmail.com

Changes in v5:
- add a separate small-page command-handling fix: use READ0/READ1/READOOB
  with the page address for rereads and normal OOB access, and select PIO
  instead of the large-page DMA sequencer
- keep physical reread errors visible, preserve the OOB cursor and retain
  the existing ECC geometry requirements, including rejection of 512+16
  with controller ECC
- group the small-page fix and the DMA register-bank fix with the opening
  fixes, ahead of cleanups, bindings, format support and optimizations
- make the DMA register-bank fix independent of randomized-OOB support
  and the later register-access optimizations
- Link to v4: https://patch.msgid.link/20260912-submit-sunxi-nand-vendor-oob-layout-v1-v4-0-4a64bed94229@gmail.com

Changes in v4:
- prepend an independent fix for completion reuse and IRQ timeout races:
  initialize the completion once, finish IRQ register updates before
  signalling success, and drain timed-out handlers before clearing their
  interrupt state
- add a separate fix for aggregate protected-user-data register overflow
  by splitting DMA transfers into bounded batches, retaining the existing
  OOB layout, ECC offsets and DMA support
- distinguish logical page steps from batch-local hardware slots, retain
  page-wide ECC accounting and avoid retrying partially transferred writes
- Link to v3: https://patch.msgid.link/20260909-submit-sunxi-nand-vendor-oob-layout-v1-v3-0-838cb0ba1547@gmail.com

Changes in v3:
- add a prerequisite fix for the logical OOB length used by PIO transfers
- clarify logical ECC steps versus hardware slots and share protected-OOB
  register indexing
- select the controller-specific vendor spare-byte erased-page check from
  the SoC capabilities, only in randomized-OOB mode and without rereading
  the main data
- retain hardware-decoded data and protected OOB on other ECC failures
  for bad-block and BBT pattern scans (reported by Miquel Raynal)
- retain a bad marker and ECC failure for all-zero physical pages, and
  disable the ECC exception for the vendor format
- share page classification between PIO and DMA, reading complete pages
  for randomized-format subpage requests
- propagate OOB read errors and defer randomized-format ECC accounting
  until those reads have succeeded
- propagate read/program setup, column-change and buffer-transfer errors,
  including extra OOB; stop failed writes and disable ECC and randomization
- discard partial DMA ECC statistics before retrying in PIO, and keep
  correction counts separate from successful OOB-transfer status
- select the current hardware step's pattern ID instead of slot zero
- avoid a second program confirm after an OOB-only write
- avoid redundant column changes before writing extra OOB bytes
- reject oversized ECC steps in randomized-OOB mode before the core can
  fall back to software ECC
- combine adjacent parity and trailing OOB reads in randomized-OOB mode
- remove duplicate chip setup immediately before core page commands
- program each packed DMA user-data length register once per operation,
  and write PIO slot zero directly without read-modify-write
- reuse pattern IDs and packed error counters within a DMA read, while
  refreshing the snapshot after every PIO ECC operation
- Link to v2: https://patch.msgid.link/20260904-submit-sunxi-nand-vendor-oob-layout-v1-v2-0-b12074f4aca7@gmail.com

Changes in v2:
- rebase on the current MTD nand/next branch
- retain the merged protected-OOB allocation, BBM reservation and
  stack-buffer fixes
- clarify that randomization is part of the normal hardware-ECC page
  format while MTD_OPS_RAW continues to expose physical bytes
- explain why a BSP-compatible BBM remains randomized in physical raw data
- document the decoded bad-block and flash-BBT access paths
- reject the firmware OOB format with software or disabled ECC
- document the BSP page-format compatibility contract and the
  older-controller format audit
- Link to v1: https://patch.msgid.link/20260810-submit-sunxi-nand-vendor-oob-layout-v1-v1-0-463853a14ad9@gmail.com

---
James Hilliard (16):
      mtd: rawnand: sunxi: centralize OOB handling
      mtd: rawnand: sunxi: use the logical step's OOB length in PIO
      mtd: rawnand: sunxi: propagate page-setup and erased-check errors
      mtd: rawnand: sunxi: drain interrupts before reusing the completion
      mtd: rawnand: sunxi: stop failed program operations and disable ECC
      mtd: rawnand: sunxi: select the pattern ID for the current ECC step
      mtd: rawnand: sunxi: propagate buffer and column transfer errors
      mtd: rawnand: sunxi: avoid a second program confirm for OOB writes
      mtd: rawnand: sunxi: use page reads to reposition small-page NAND
      mtd: rawnand: sunxi: bound DMA batches by the user-data register bank
      mtd: rawnand: sunxi: reuse ECC status within each transfer
      mtd: rawnand: sunxi: avoid redundant column changes for extra OOB
      mtd: rawnand: sunxi: avoid duplicate chip setup before page commands
      mtd: rawnand: sunxi: reduce user-data length register accesses
      dt-bindings: mtd: sunxi: Add randomized OOB flag
      mtd: rawnand: sunxi: support the Allwinner randomized OOB format

 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |   10 +
 drivers/mtd/nand/raw/sunxi_nand.c                  | 1537 ++++++++++++++------
 2 files changed, 1065 insertions(+), 482 deletions(-)
---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20260810-submit-sunxi-nand-vendor-oob-layout-v1-e3114d10cc9c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

