Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F6390CAE
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266373; cv=none; b=YU4abM2ahHdCJ0e/Ie28iybQnf3/Ww5Iu7Gi4HPbhpL3Ldxov4sI0g5/8/kLn82goj/sdmjDoSdMeYZCQntFyI0J0L6soBrWBUUx3jZTP5BSMibe/G69M2dBdRB5/uUnB8a3cU++RKfG3xU+qSHi0bYhunQPqQnG0JZhz/FaN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266373; c=relaxed/simple;
	bh=ZsisjnqSttJ4KE8ATzeY3F/Qtxk0ftJjUAROm3Y/9HY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UeTWQ4DEADtoWt2IDoViQbG3Tv2bSLZ6pSuMgjw4RgZQMFY77IiRxK/KShgive2ymTFFRO0pJO3vJc1WHwbJhWAh02E1nnKmIpN65MHwNe2B8o/xPc6cvR7CNSbWGZ3PS9ylgXqv2atX1oO70M+70yOSY+Ormk9YVRLjTmq/mSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyTxz0UW; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyTxz0UW"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4f699fe49b3so728197b6e.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266370; x=1792871170; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y6U7yD1KMbiV4YstLaKTX39G1im47gZROCUD/mh3EZM=;
        b=KyTxz0UWuLU/b8Fs2MVzUy377q6UR+xalRCpqj1AQdiKyhUO5HmZcwCEvXW5PCQkck
         gdzhbscocQGNWx2Z799YVtJXZdDBrtdoT+GQDpv1jCDoh6bq2dfDecRtqSpWvU8oJbi4
         TQEUW5U1pRTrMOz1bUveqrhnba9MvIR+KmQeY7iqRnzbW2QXHC6pULfQpFj5v+fYIpfT
         ozjqLlkMvhhoH2GYbm+mPcb7rdOl5V9wA12/JLLt586zQBK7HjWPG0gVFlTlGOJOpK6y
         aYj+wwK3zEAiOd4tUC3644BAsfXWrfcxXFfrpelk9Dlg7oJnihzBkOnjfz/AQYUOWdki
         GUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266370; x=1792871170;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y6U7yD1KMbiV4YstLaKTX39G1im47gZROCUD/mh3EZM=;
        b=uVLuoSJvVfC0HveoL02lxzmeygnmLcaNrRwd28WhD0dZG3YAI4mlSIjO68qXt2zkz8
         LPteiSA+bCjfkk65WtDXv/UzGf5cw3TxTI/UCKNidIhyPQe7ml3azzFmBlipDvRCDqUq
         SVXOs/o/sftP49iJgi8AZ9+mhgtT6/4Z8rkc1imHZe3ItPEtx8ulka2P3MCDz+O/We2E
         kVk8XukD2IUkPZkz+YTaibSjclwEwIoWHtcGZKtXDfCLayjY+HbIc4FxPykqTgQNyDu/
         5BMHSs/1oYeEjxL2w+xADhftbgUi7FCohtgjJvOal/QJQxAIQaoPn8vv9hOPj7oadto6
         9COg==
X-Forwarded-Encrypted: i=1; AKwUvBzsCoCfdHRE6Yu2QT2wmhnQw8OAoKXcUjEnRzqF/FvoJBbtkQQBn20VeaDBa1oRH+ax1TuMV9RqYv7QrPEnVg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIDWECaNEFrL8eI8TAc8MN872WMY7kS0N6WjormJaIv+GYv0zUH
	Hjm4POlXr3gB98+KMiDu8o453bzsKteyMqCMmh1YfBcbI0tyxpbWESLI
X-Gm-Gg: AYBFou3d5iOpg5AvCcHzZDU43kPIuEegpjgKqpVl3BHqCuXZU31W7oPejXFmHIwC887
	fAVGxKS8tX8WmVE9EXMRtTUrSAE3EeQu7nxcVQypnG8HsE/bBUTBEsLCrwFR7K0lWrhEX24y3F8
	zpCFzAnPq8//vmdFD5Tgid8JABxLcFJWcXbMsJcsXDCLJxkXapaS54r413CQNJV6ZGYhDYcRDMX
	kwbQk7ZOtx1HcDy/8mcY+UOTXqDR2W+aVyZXc48o+ruqmQNxAxv+xFauKh2FgJ46P3vsSmdxeJi
	T2CiHmGVsW+mYtwJwhY5aUlXu/yZgOg0eVT+r2jDfPM9RmTxcYK9R1xNEPbykhLbNL705iPnlEG
	shrlV1vDh4EcKF6w1y7L/kuxYssxK8aNGfHnGt4LZG/CkST6GjAGAjNqleuzxWd8i/Ax84H1Uf9
	2WfMto06FPkh0iSutX1eyspGQV1+V2Yq5Ae6jvmAWugNDL+IChd2iS4nbkGcWncHzmfUT3sUDvx
	skCxieXiuSHrsJkNZYvSrAOoDbKAddfHjGCGwWCdeRG3zsqeTnb3EPtYTCbnsBk5cJUt+NfTwTQ
	uhOctutgELWCW6un2atV6ufiawr3U3rUJFfMg68NP5MqSofFWKKxXALf6Sp0buv+ZNvdlCH+d0V
	LjsxI01YcwYqwgu+P/s0Gfw==
X-Received: by 2002:a05:6808:4f1f:b0:4b9:a8ac:479 with SMTP id 5614622812f47-53ccaf25927mr2916541b6e.23.1792266370041;
        Sat, 17 Oct 2026 12:46:10 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388dd8b5a2sm4025321b6e.12.2026.10.17.12.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:46:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v9 00/18] mtd: rawnand: sunxi: fix transfers and support
 randomized OOB
Date: Sat, 17 Oct 2026 13:45:55 -0600
Message-Id: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XRS2rDMBAG4KsEraui0dtd9R6li9ErUUmsYjsmI
 fjulVNoTbxxQCB+GL4ZZm6kj12OPXnb3UgXx9zn0tbQvOyIP2C7jzSHmglnXDMLjPZnd8pD/dp
 Lpi22gY6xDaWjpTh6xGs5D3QEGgWADMC8bzyp2HcXU77cG318/uYqfUU/zPpcccj9ULrrfZIR5
 rqnm9bHqNTCKoEgMTTv+xPm46svJzI3Hfk/2zC5meWVdcCZkUmiR/PIiiXbbGZFZa2w3jGHoOS
 KlQsW+GZWzktALV0MjeR8tQS1ZMVmVlXWBAPAjEadVtPqJbt9t7qyPDlmZYrMKHhkzR8L7AnWV
 FYFkbzGwAOuWLtk1WbWzidzKK2F5GK0S3aaph9XhcTCTwMAAA==
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
 Sashiko <sashiko-bot@kernel.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2

Patches 1-16 address the existing driver independently of the Allwinner
randomized-OOB format in patches 17-18. Please review and apply that prefix
regardless of whether the format extension is accepted. Supported geometries
keep their existing on-flash ECC layout, bad-block-marker representation
and raw callbacks.

Patch 1 centralizes OOB handling without changing behavior. Patches 2-12
fix the controller's ECC step limit, logical-step lengths, read and write
error handling, completion reuse, pattern handling, duplicate program
confirms, small-page read commands and the H6/H616 user-data register limit.
Patches 13-16 then reduce repeated status reads, column changes, chip setup
and length-register accesses.
The pattern fixes precede status caching so correctness can be reviewed
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

Patch 17 documents the opt-in binding; patch 18 implements the format
through separate OOB callbacks and an attach helper. Its geometry,
page-wide classification and contiguous parity reads stay together.
Without the property, existing format selection and callbacks are unchanged.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Changes in v9:
- Add an independent fix rejecting pages that exceed the controller's ECC
  step limit, as reported by Sashiko. Keep it after the initial refactor and
  retain the final ECC step size when validating explicit or maximized ECC.
- Add missing Reported-by and report links for the IRQ lifetime,
  small-page read and DMA user-data batching fixes.
- Make the existing PIO and DMA OOB-read branches explicit in the initial
  refactor, preserving their transfer ordering and error handling.
- Add a cached pattern-ID accessor with status caching, so the Allwinner
  format can request pattern IDs without duplicating the shared reader's
  register-read conditions.
- Clarify OOB callback indices, buffer and ECC-cache lifetimes, and why
  an empty pending-event mask completes the IRQ timeout recheck.
- Explain packed parity placement and byte-based erased-page classification
  as Allwinner format compatibility rules, distinct from hardware limits.
- Link to v8: https://patch.msgid.link/20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-0-8ba4881fbee8@gmail.com

Changes in v8:
- Add a separate fix for the pre-existing zero-pattern overwrite reported
  by Sashiko. Preserve synthesized data and OOB in the existing-format
  read path without treating zero chunks as erased.
- Place the fix after pattern-ID selection and update the later status
  caching conversion to use the same pattern check. Keep the initial
  refactor behavior-preserving and the Allwinner format callbacks unchanged.
- Recheck the remaining command/DMA events after draining a timed-out
  handler, as suggested by Sebastian Andrzej Siewior. Accept completion
  during cleanup and balance IRQ disabling even when the recheck succeeds.
- Link to v7: https://patch.msgid.link/20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com

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
James Hilliard (18):
      mtd: rawnand: sunxi: centralize OOB handling
      mtd: rawnand: sunxi: reject pages exceeding the ECC step limit
      mtd: rawnand: sunxi: use the logical step's OOB length in PIO
      mtd: rawnand: sunxi: propagate page-setup and erased-check errors
      mtd: rawnand: sunxi: drain interrupts before reusing the completion
      mtd: rawnand: sunxi: stop failed program operations and disable ECC
      mtd: rawnand: sunxi: select the pattern ID for the current ECC step
      mtd: rawnand: sunxi: preserve synthesized zero-pattern data and OOB
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
 drivers/mtd/nand/raw/sunxi_nand.c                  | 1578 ++++++++++++++------
 2 files changed, 1109 insertions(+), 479 deletions(-)
---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20260810-submit-sunxi-nand-vendor-oob-layout-v1-e3114d10cc9c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

