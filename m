Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911034;
	b=Rx8IiUi56WfPrALYx4928PCVkPMKVufgRv/h8nBpaRz1p8MyJVnFUZCLaN/O0BeZumW4
	 tV6PN2c1CZPj6CMkomkpasbB6Ry/i6I6J02bx0k1EwmvQ6pnMhD2KKk/h6Y4Sh+yn3vIZ
	 YKdBnFXqruIEbiaEVgpxO1vUrwkzo5uTM+gAmMBTUkxT0OFjI3FWgFYovBMZCuXHXTeo4
	 8c4ZmT2HvutpJEVIB1BwVTDXoej3xDoZdfPUrhUrJTAWXOqiA+3YchTs1kwRqMazJYsIn
	 5M00rpdkHTp2GvHy5r90UHjpPYHgcsc+hf1y8HClOKuf2l5ePURnA9ibv5cqI+SQfIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OsK3MYz9w+yugO7b/K4HKpqaj9q9ojfCF04yLKl5NIw=;
	b=GZAB34gsVxD8wwgwLU4LUyad4oXs75gAsnxq52P0dzQWEWpLCH2Izkf0z0ei0O/3ykXZ
	 0nRnPVxbMd5xA/zsI80E/9CFtcZwEwfnxoOn3dL/qDhJG+PQcd4AHEiZm4y2tW5XOU0tO
	 smLQvMRAXimfKQXuAGND9mNiFuyEvWguKYdQ30MtVJuIkRyJup8sDEkaCL4jsHfWaczGf
	 fE0ZcEg7Jq2LHblHNpQ8p56ufVMuKGrpXxbDD1e0Rk5CzZz1gY3y0oHprtiAxhAft3oze
	 vWZ0rEGJnRZzQNHvLmE9ygp7tJRCozLpcBxHrMYeHVSPMibAPdVwg/i3wTUy8qnCYYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3noLXC2;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832BF606D83B
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 20:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 832BF606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3noLXC2
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4395d31228so13406366b.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 12:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911032; x=1794515832; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OsK3MYz9w+yugO7b/K4HKpqaj9q9ojfCF04yLKl5NIw=;
        b=a3noLXC2n1OINj5uiPk+S0VXpBT8yqhLNQEuHHYVrwxqWOgiHb8qny/gcKrswsXr2K
         Mq7qOYPrw6EPnr5Uno2+BJw4s9GKqoOhlnnQigwmtqGWtXTL6WiS1wNJWHea1bT3Q4rh
         sr7JHIY7gpBVyxAcgxwWXAoqzDQ5ZuCAxaR13nwt3gqCUBRNtqo6UWNsqBIB4LbEPLr5
         81DMYDW0N1RA8/BiSBzDp7M29x2HtKCs7LcDitEO7b4c0x/qowhRXdnBcyqG/IxedoVF
         Hl43VWOcnk/LxqsChrTrzmjlFIFxgsCFrndXG1UOqEnuo+udVNs0k47uSD4geUOv9qcx
         /z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911032; x=1794515832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OsK3MYz9w+yugO7b/K4HKpqaj9q9ojfCF04yLKl5NIw=;
        b=bSUOkSuvQ1dqb+O/6daBOhh3Awf+4RBXwhbU4EtYh7ddYxk739ILnmn0bgxNMaYoY7
         3KKFxpGJOan/iOhPISaV7uUM4hYHnFmfsFDQBW/Uz8A4BJAkvR05nVIYR3ABEcgJwesw
         5EFhKl+hjHdYaV1n4LCr3W9VuRGM2xdNUc1rilhUhSRjjLKxDQ3KuUJVdKurC4AevC43
         QiXIM3tb0OFWPn6bpnGTh1EBlp8DYbJOadjCMeReqM5Xr0141QLFeDL4oSgaY4TiB6HM
         RUa614HHXBf/WMMNWbBAWLpGx+4ZOU6h4uFFytWhBBOyD5xe3sW0e0I+1uGDYcZaWKjl
         sxHg==
X-Forwarded-Encrypted: i=1; AKwUvBy+11iXrTaiWOBzw9Bd6KhCgf7YfYIEYvVMf9hKE6XzcohCyiMQ1EchanooPt0BTlFHdcRwoXLv5ULGVPODsQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/YDNWsEsKRO4YylB3KfC5IZ+9Ntf4dTKlZbkOfzHkrHlzlvTCA
	3VwsvkjCUS7QKQQz0gMnNld+3L6C2gY+CsX/uTEYBJnaOEreArwbDDNr
X-Gm-Gg: AYBFou2Ut889ht73zc3EpK8oB+Tz8yp9ENu3xSyI9kqi1kM9ksILJMGg6OvrDdeFu7s
	6YPIxulQU+MnjtbnG6RtAzHJUVGjHCHbJ7cI7f7edwTsI7iEm3edJXIDbpJ/r4lCSndZNFtpvHg
	nfI5TSbu88QOPfKDRqm7G5uiXmA5Xapeaw0lwp9hsEN5oj3MDZ9hoRnMFAyaohaFAsHKcO0p79z
	7qsFathZJUlYZ4ztM8yTkfTCcI4Cj8AMEM72vC/obB+I8kKO4+49y3p40eNdoyhBTOoDeAuIICY
	31m8BskLWTZt+XvkhHtVSiuWRSFsTa4WQHXKO4jUrj5Q8az8xCsvCHJevphbjeDaCyA6IWcsdCX
	nXUP0dGxfvRjMAJAIjxWDrhLE1UANHjboffSLUAqPAMoZ7yy5clCQU38Gk0otuDpb0VdVUXnd8X
	KSAnxlMc9dizyTr8q0lT/DDWdXpWbaEcrnnHUHFli8DB8iw8O5xc2ESlsidlbHjQPd1tT+wuTnA
	oAOd4Nr6HWGuOkHhRG82QyjIMcWLjHL/Yd1wg5HFzLcgWc4xynghKU1qvgIXT36Uabl0Be/RTHF
	ekSWzD+79kQJ2py1xiHhDertA3fNOle44UbSlBlBz9PxAQOSo6CKlwJ2AFn8yKPwHnc16HTV30g
	ZoMZKgu2NB27sqyO6OM88FbXDvqcRZZD/KZqyMbevyb3VYRllaS0odflsLB8TAfojmEYAKf2V44
	2KlGc0iUq2LqnDVbJD/Ed0EFOkxiKYtSbVzz0pjhANQNs9aGxFm7gpIzsgeaDKBugJew==
X-Received: by 2002:a17:907:d30a:b0:c3e:cb50:b7c8 with SMTP id a640c23a62f3a-c4d353f3dbcmr54320266b.12.1793911031659;
        Thu, 05 Nov 2026 12:37:11 -0800 (PST)
Received: from mb-HP-ZBook-Power-16-inch-G11-Mobile-Workstation-PC.dynamic.ziggo.nl (2001-1c00-1106-0900-938c-4ed8-a3bb-093f.cable.dynamic.v6.ziggo.nl. [2001:1c00:1106:900:938c:4ed8:a3bb:93f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569f518sm15429966b.56.2026.11.05.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:37:11 -0800 (PST)
From: Mario Behn <mario.behn@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mario Behn <mario.behn@gmail.com>
Subject: [PATCH] spi: cadence: recover the controller after a failed transfer
Date: Thu,  5 Nov 2026 21:37:03 +0100
Message-ID: <20261105203703.979067-1-mario.behn@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a transfer times out, the bytes it clocked in are still in the RX
FIFO: the interrupt that would have read them did not run in time, and
the host path never drains the FIFO between transfers (only the target
path does, in cdns_unprepare_transfer_hardware).  Every later transfer
then reads the stale bytes first and returns shifted data, and the
device behind the controller looks dead until the system is rebooted.

Seen on a Zynq-7010 with an AD9361 on spi0 under PREEMPT_RT: after one
"SPI transfer timed out" every register read returned 0xFF, the status
register showed RX FIFO not empty while the bus was idle, and a later
sample rate change failed with a calibration timeout.

Add a handle_err callback that masks the interrupts, drops the stale
bytes and brings the controller back to its initial state.  The next
message sets the clock mode, the clock rate and the chip select again
through the usual prepare_message, transfer_one and set_cs path.

Signed-off-by: Mario Behn <mario.behn@gmail.com>
---
 drivers/spi/spi-cadence.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 50ef3a7871c2..474ce14a59b3 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -542,6 +542,30 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 	return transfer->len;
 }
 
+/**
+ * cdns_spi_handle_err - Recover the controller after a failed transfer
+ * @ctlr:	Pointer to the spi_controller structure
+ * @msg:	Pointer to the spi_message that failed
+ *
+ * A transfer that timed out leaves the bytes it clocked in sitting in the
+ * RX FIFO, because the interrupt that reads them did not run in time and
+ * the host path never drains the FIFO between transfers.  Every later
+ * transfer would then read those stale bytes first and return shifted
+ * data.  Mask the interrupts, drop the stale bytes and bring the
+ * controller back to its initial state; the next message sets the clock
+ * and the chip select again on its way through transfer_one.
+ */
+static void cdns_spi_handle_err(struct spi_controller *ctlr,
+				struct spi_message *msg)
+{
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
+
+	cdns_spi_write(xspi, CDNS_SPI_IDR, CDNS_SPI_IXR_ALL);
+	xspi->tx_bytes = 0;
+	xspi->rx_bytes = 0;
+	cdns_spi_init_hw(xspi, spi_controller_is_target(ctlr));
+}
+
 /**
  * cdns_prepare_transfer_hardware - Prepares hardware for transfer.
  * @ctlr:	Pointer to the spi_controller structure which provides
@@ -727,6 +751,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	ctlr->prepare_message = cdns_prepare_message;
 	ctlr->transfer_one = cdns_transfer_one;
 	ctlr->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
+	ctlr->handle_err = cdns_spi_handle_err;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->flags = SPI_CONTROLLER_MUST_TX;
-- 
2.53.0

