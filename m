Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172032E142
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Oct 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713321; cv=none; b=JG4PGch+UQVlMdBKek8jhOlqWcVEWJ8wvRkkzEkzIfrGjJzXeu65BMR+wyVjG70uKE965bXnRWNNnzEaM+YHQM68M7bV57Kazap+WVqHcz09MfrQ91IuuWQatx3m1c8vEYXLSqZ+004QNQ8FYqoQHzv6pHN74LbwWSUHpjf/zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713321; c=relaxed/simple;
	bh=FfsFoKWSKYMslkjGboQj+clwjopcTUOyJUtqNxBB8I0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G/HFBu0sB+n63mgSUEyuI2B0Ykz/W6sm9BHhepD+0HRmsCi/aOfLZug8QJMISD7UyAoI+e3v9Ks6XV7DBaFBepGr3UNWakUlgRQ/13xsM4YbXPFBUA714zvKuNeHabOAP29eyUpnCBV/5bYnPA98TWT6ypmNQsf5wYH5AsNxWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=22VG2ftr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="22VG2ftr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 662461A1483;
	Fri, 17 Oct 2025 15:01:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 392E2606DB;
	Fri, 17 Oct 2025 15:01:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE159102F2364;
	Fri, 17 Oct 2025 17:01:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760713315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7WJkdH6BRRi4yhVXnTMucIDdc1efpn72Af3qKfr+EfI=;
	b=22VG2ftrt/gp5Ibko6RFr4eXr0KkJFDy9Q31TsVgbfSOajXRkcBiylb50l3GsCuP0t+8GU
	+4ZE/1Jar0Sw5WQBfq5HLsprU3IRu/7adk4A9+JeyUN+yUiGWx8jCXrI/Z+Zy4YObkaHU1
	M+PZYxQEPRDJA7Rq1Td9zX7c8jZogc8Jkqo5JzXfC7ErS2aC24To/bdUoYYMp87z7VAsDL
	/GCBFTatF6wENGOcUskjS17h/pU5TtTwBfxqWj+PbJUrMlwotYVu+qVY3CYzSoFiJxkGoR
	Aqn9Vr8Dyj1gznupP/s80MjIwhITDNND8MVef+MIBOOhwya4ps2yeCf3tJs9yA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH 0/3] i2c: designware: Improve support of multi-messages
 transfer
Date: Fri, 17 Oct 2025 16:59:31 +0200
Message-Id: <20251017-i2c-dw-v1-0-7b85b71c7a87@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANNZ8mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0MT3UyjZN2Uct2URGND0zRzUwsjSzMloOKCotS0zAqwQdGxtbUAvV1
 8vlgAAAA=
X-Change-ID: 20251014-i2c-dw-da315f758296
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Extend what can be done when transferring multiple messages in a single
call to .xfer().

Allow changing the target address by waiting for a STOP then looping
in i2c_dw_xfer() instead of erroring out when a change of address is
detected. The loop then re-run i2c_dw_xfer_init() which changes the
target address and restart the transfer for the rest of the messages.

Handle controllers that lack the ability to emit a RESTART when two
consecutive messages have the same address and direction, by waiting
for a STOP and restarting the rest of the transfer.

The i2c controllers found in the EyeQ6Lplus and EyeQ7H SoC from
Mobileye lack such capability, so compatible strings are added because
this cannot be detected at runtime.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
Benoît Monin (3):
      dt-bindings: i2c: dw: Add Mobileye I2C controllers
      i2c: designware: Enable transfer with different target addresses
      i2c: designware: Support of controller with IC_EMPTYFIFO_HOLD_MASTER disabled

 .../bindings/i2c/snps,designware-i2c.yaml          |  2 +
 drivers/i2c/busses/i2c-designware-core.h           |  1 +
 drivers/i2c/busses/i2c-designware-master.c         | 97 ++++++++++++++--------
 drivers/i2c/busses/i2c-designware-platdrv.c        |  6 +-
 4 files changed, 68 insertions(+), 38 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-i2c-dw-da315f758296

Best regards,
-- 
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

