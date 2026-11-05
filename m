Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904931;
	b=D5yrFb8jRCcxYJa2BS0Jrb8qGpGs+1pB3i8fk8cZgbCrhmUQg8NtzFLE7kkS1f4wyXmy
	 /FSDD/J1nMVJQzHsemzKa5C5zPaMszQ9DZRXeY8K1d6iyw+rycbZUM2kOzI26buQqdsKp
	 Qgbe4egx81OoCLTI0dw9vyqlZjn0wGR4/ExEwihfCICLJYvdlTPFNkCy8x/++5X1jHNMm
	 vCmAsFUqp75YASYgcXZmsFZiDKd/chMXQEVpuOWFr5Mln2+2kKuEr0LDaDaEip7ENaQIQ
	 MfOaZPb5vSGsoB44raTHrVMJWKy7vMTMPL8G9uDxaySI0pxR2B9yX6Ox6cr9aADZmxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=UMvD0QNhuIqJcyOdighp/tGvQpuMow4V22PsckR2fAU=;
	b=X20OTlZihJJWEoa4kgVTBSgKjFv045c3y4Hpnn9MHtvbdc1r+I+I7YsDvO5qEQX3ja63
	 cseBjWJFxidWAsavTow9Bqo46jILKThgfelms44ZcrWdpDRGQU7j6XaoLynmhlchYEFBZ
	 0bJh9bPhQH7Yup05wbWbvqZZO+1GRMJuGB+eARFtfDrXz5habJqk6S1CLfZeqPbwusyBd
	 3gN+LbuYcC6Vy/UbRj4esMNP++xwaSaUyQY9Bdkmx7gA+cImYXuimWZwCLUsA8HVQTMZZ
	 14yDC2Gmb/ufEvvK0Uxb+MMbv4RrOnv+7yf13yCjEPX0qBgUKESHXk4CgJOSaaEEd0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FOctZ3HW;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950B606A329
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7950B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FOctZ3HW
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f84a55cc06so1520252a34.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904929; x=1794509729; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UMvD0QNhuIqJcyOdighp/tGvQpuMow4V22PsckR2fAU=;
        b=FOctZ3HWmpppD4HiNDQGnYZhh3G3OwKpU1mu4ORBArUV6bdTRLP0t0Pgc5In11ZOVz
         DjESW2/WMoJvpf7ytbsEdo7cd4gZ8X6MeJU4jRRTTOYwC9Z1ngar638/+J0hhisI5Hze
         l2PIaG9hV4QJjGvctGxWPkupGS9dRquieI9LgleSXx4llq1BVVnX6F2sOukCtuisqq9J
         m7d/hM2QcV+jjln/Nn/fzgQdZF5+UvqH4YWaBJVV9CNJB42wcG+oC/oH7ulOkPMdQcvd
         FeS1HH3I5oY0o6Xa1RzoI/MvKjrfsSYJ9X0HQfxvUvUAHUCXsfn3tZ7NXxesKdHEDMH4
         B6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904929; x=1794509729;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UMvD0QNhuIqJcyOdighp/tGvQpuMow4V22PsckR2fAU=;
        b=IB58v/darKw1WztN5V0jf21S/d8aJWZ9juHf0odN0LKeCxLf5Gue73ELFfVzpRhXoP
         hmfY+29wx8ChY9Zx6dT7VDPWI4+J5SZBwwAajvHLkyt8QcdHD99KlXNv6rKWHAS8fXLx
         GEe3tz/ALJjUlUk/OGcsB9hnzLMWAJQSXknsbRvEQqVNKBzkMotoqy9y4qQvYkyCyrKf
         YR2JoFWs/8PlMJrCT7pkQQdsHyojD2Gc6yrCP8byUtdYYPgDVACf0PhUdZKPkCrV/G3x
         suz9amBWEhM3lPC9+5ePg5sMAxFBS2c5OOE4PdKArBB5N5qg4SUBNd7iHnLpvxRN2rgR
         6PwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtzw52mZgVtBmdKTWBe86CdyGLoPjGgO4U3XldApYvkMgcdxIDOQpF8IGr/joDZwWNIhBO2T1m0zfIwdGUTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8PKRneSLW3ucgvYPQmD4LTlEi1F1DYjgTWHjsNWCvzw6wicizF
	VJkfIjpcexxGgCUHjAw3AXFy80PfkiJ3uTXpxGZo3SemJCM46BUio/BQ
X-Gm-Gg: AYBFou2lq9dGppR9H+mlDX//N5diYXjHzqSPnVFzxcJgV+7JIYzRFIYqg2lkGUSVU+8
	8MMPV1Ee23yATlw9ijkGjG2mWKwJFGblKuExSC7kvD6jqLPxL6dXfa13X7qb517+/HHW6IunmhA
	0jDSSW6jkl/tIe0IPPQyXyqmvu/3XQ1gZ1Up2mp28HmOKJHQ+TAZVMhnHiuWz/WO5luMDKrx6aW
	BDHM5x9po74hsDB2/SWOH9d3lRiTAEiq27KYj1gJXRgl2+zvGcd5ieQbYTL6EpZZh/J3x9VZzhm
	8uPBsL6haA4eooEBqMc9//um561F/sVNgGtsW/7D9q3O0coc33hVTP1Ow1vWrxK1sqbmAKqZOEl
	C4nFjfw1UZ37Uip1bN7n1Z7O71IIbIqWfnB2eJabkweoL3CfOLbKEMbzobB2iOac6BM3agJBbRE
	K2Cek8k7cFR5hcwxjygEOVpOT5a2mVlcELyr5k4qoOj2HmR4umNJ0hC+u2NJH7RlEhT72FXx8Un
	y4KAYvCuHBJoyn87QUrfV8r9+YIdiQ0lh1Cg7RYLsL9tdUMi7FH2yToucbMlMDAigGIsz6uDP/R
	JYJk5DQSzrePXz81jSNS6XA5RiBGBvjhabu/IRyGamGreEmUHSoXCK67p1Cvsx4C/m9e2a3mngd
	WDyAOsFRekC5zBKelZ3IVa084TxFffdJ+DusWtd0jFq9E2ZwzVwMYzNjskBzU1oWJ9KgeSYLONA
	zZO4O92zIlJZvCsWwjF7UJuB9J2SJJ0Grxx+Wk8DMOKCUfx1saCkcRNQ==
X-Received: by 2002:a05:6820:c5ce:20b0:6f7:7a4a:9d7b with SMTP id 006d021491bc7-716e790c1c8mr291036eaf.41.1793904929156;
        Thu, 05 Nov 2026 10:55:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:28 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v10 00/26] mtd: rawnand: sunxi: fix transfers and support
 randomized OOB
Date: Thu, 05 Nov 2026 11:55:16 -0700
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XSzWrDMAwA4FcpPs/D8r932nuMHfyjtB5tMpI0t
 JS+++wOtpBcUjAYCfFJyL6RAfuMA3nb3UiPUx5y15YA2MuOxINv90hzKgnCGdfMAqPDOZzyWK7
 2kmnr20QnbFPX064L9Oiv3XmkE1AUADIBi9FFUrDvHpt8eXT6+PyNi/SFcax6rTjkYez662OUC
 Wrd003LYVRqYZXwIH1y7/uTz8fX2J1IbTrxf9YxuZnlhQ3AmZGN9NGbJSvmrNvMisJaYWNgwYO
 SK1bOWOCbWVmX4LUMmJzkfLUENWfFZlYV1iQDwIz2ullNq+fs9t3qwvImMCsbZEbBkjV/LLAnW
 FNYlUQTtU88+RVr56zazNr6ZMFLa6EJiHbJujlrNrOufjDNZWQOBaKas/f7/QehJgYopwMAAA=
 =
X-Change-ID: 20260810-submit-sunxi-nand-vendor-oob-layout-v1-e3114d10cc9c
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2

Patches 1-24 address the existing driver independently of the Allwinner
randomized-OOB format in patches 25-26. Please review and apply that prefix
regardless of whether the format extension is accepted. Supported geometries
keep their existing on-flash ECC layout, bad-block-marker representation
and raw callbacks.

Patches 1-3 prepare the shared paths: centralize OOB handling, share the
NORMAL-command chunk-size calculation, and remove duplicate chip setup
immediately before core page commands. The DMA writer retains its early
setup because it accesses controller registers before program-begin.

Patches 4-21 fix the ECC step limit, logical-step lengths, read and write
errors, completion reuse, pattern handling, duplicate program confirms,
small-page read commands, DMA user-data bank limits, split address cycles,
clock setup errors and direct buffer transfer counts. They also skip
unavailable NAND children and complete all chip scans before registering
MTD devices. H616 abort recovery performs the AHB reset before releasing
the DMA mapping. Unexpected reset errors block further I/O and are returned
to the caller. Each fix explains its triggering condition independently of
the format work.

Patches 22-24 then reduce repeated ECC-status reads, extra-OOB column
changes and user-data length-register accesses. The pattern and transfer
fixes precede these optimizations so their correctness can be reviewed
without the caching and fast-path changes.

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

Patch 25 documents the opt-in binding; patch 26 implements the format
through separate OOB callbacks and an attach helper. Its geometry,
page-wide classification and contiguous parity reads stay together.
Without the property, existing format selection and callbacks are unchanged.

The accompanying TLA+ models and validation material, including their
assumptions and coverage limits, are available at:
https://github.com/jameshilliard/linux-h616-nand-tla

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Changes in v10:
- Require resets and reset-names for H616 in a binding patch before the
  DMA-abort recovery change.
- Reset the H616 data path after DMA aborts. Require and exercise its
  exclusive AHB reset at probe and reset before releasing the DMA mapping.
  Propagate unexpected reset errors and reject further commands after
  failed recovery.
- Group shared-path preparation before the existing-driver fixes, followed
  by register-access optimizations and the opt-in format support.
- Share buffer command sizing between reads and writes, and use those
  boundaries when decoding a randomized tail spanning multiple commands.
  Keep the decoder correction in the format patch.
- Skip unavailable NAND child nodes before claiming chip selects.
- Scan all chips before publishing MTD devices, with separate registration
  bookkeeping for partial scan and registration failures.
- Limit direct buffer transfers to 1024 bytes per command, independently
  of the advertised SRAM size, and share the limit with the parser.
- Send every address cycle in parser-split instructions, using the subop
  count independently of its start offset.
- Propagate chip clock setup failures before installing timing registers
  or issuing commands, and update the cached rate only on success.
- Carry Sebastian Andrzej Siewior's Reviewed-by for the IRQ lifetime fix.
- Link to v9: https://patch.msgid.link/20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com

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
James Hilliard (26):
      mtd: rawnand: sunxi: centralize OOB handling
      mtd: rawnand: sunxi: share the buffer transfer chunk size
      mtd: rawnand: sunxi: avoid duplicate chip setup before page commands
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
      mtd: rawnand: sunxi: send all address cycles in split operations
      mtd: rawnand: sunxi: propagate chip clock setup errors
      mtd: rawnand: sunxi: limit buffer transfers to the command byte count
      mtd: rawnand: sunxi: skip unavailable NAND child nodes
      mtd: rawnand: sunxi: scan all chips before registering MTD devices
      dt-bindings: mtd: sunxi: require the H616 AHB reset
      mtd: rawnand: sunxi: reset the H616 data path after DMA aborts
      mtd: rawnand: sunxi: reuse ECC status within each transfer
      mtd: rawnand: sunxi: avoid redundant column changes for extra OOB
      mtd: rawnand: sunxi: reduce user-data length register accesses
      dt-bindings: mtd: sunxi: Add randomized OOB flag
      mtd: rawnand: sunxi: support the Allwinner randomized OOB format

 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |   13 +
 drivers/mtd/nand/raw/sunxi_nand.c                  | 1713 ++++++++++++++------
 2 files changed, 1229 insertions(+), 497 deletions(-)
---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20260810-submit-sunxi-nand-vendor-oob-layout-v1-e3114d10cc9c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

