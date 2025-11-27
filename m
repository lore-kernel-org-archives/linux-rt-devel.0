Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12BD337112
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258231; cv=none; b=SNDnG/8oVuoNpiWcIk5CumymIcuq4D6F5HkCiHYyjC5CL4Mxmrs0An9b6hWsK+CaxEFShSV7HkielJKwKSxycczl7GgzVrf+wV+TbzFVNIy5kmCsKVzj6VY3C7TvVDAwuzCHzG/RrBl/yGr60DcvLRLbIHXftLlo01BA3sH8H3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258231; c=relaxed/simple;
	bh=Z3xt4pxWhiGdDKM5sFaOM6EyW5z4g5s6JsCrkgXsFcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dd3sobmrfocxMMJdEKRAg/a59yllbtdg7vmjQ4KYZ2BfidkUI1DDNtsyekEpOL4ZZol3Ul8UJ0e3KAKebCrwzXdiC1EjkwcowUh5eZ4cK5JRptl0w0r4YbzSLn3XoXlcqg+jeH1pPTcdfvkcj2xpcH5sOG10tnqnOQzGNHgQoHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34Qo+CUS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=okwMDuxC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34Qo+CUS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="okwMDuxC"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764258225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TEBjjZgz3wcBsiPytvc9Jcnj5155hhuewVMQHUXyGLA=;
	b=34Qo+CUSA+CMtgUYISw5E21lo8Y3P2k9gAG5UzhdjUeeXPzgFitNDf4vnV8VPwlC+fusSX
	ZkSlQhF0jp7ER5KRO3nr/VikoiKjUfrsK+zrvtvwFjPJanb164XPslCuvh/GwqeOmFB0qL
	5N+xN/LezewWyrVdc6Kw0SzoEooQYAqJF81m+sYHviukcG3DaeRdzz1QJ1NUUAhsdgeEn3
	Ws+MemKZPZ1BgL5U6lGm0rXhfOIhlGk3olhk/vdpnf2BFztdXI93nkdhcIWArp0gZR5ZHt
	+75VgVawgfSdiLOXG7fqdt3PzuInoTJ/isUO+476jYdzILx1cGdgMj01FDvWbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764258225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TEBjjZgz3wcBsiPytvc9Jcnj5155hhuewVMQHUXyGLA=;
	b=okwMDuxCNV/CfHlrcFJogEE08L/Yv5xyE531RWt31DKaLcQ8guYkb+uWsJWeLLovaEHQV+
	0/G8CZMLDAA0YpAQ==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 0/3] Documentation: Update the real-time documentation
Date: Thu, 27 Nov 2025 16:43:40 +0100
Message-ID: <20251127154343.292156-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series adds an overview over hardware. It does not explain every
tiny bit but explains for instance why power management or USB might be
a bad thing.

I also collected Lukas' patches which rename a referenced Kconfig symbol
and a maintainers entry for the docs.

v1=E2=80=A6v2: https://lore.kernel.org/all/20251120113708.83671-1-bigeasy@l=
inutronix.de/
- picked up tags
- s/busses/buses/ as per Randy Dunlap

Lukas Bulwahn (2):
  Documentation: update config name in real-time architecture support
  MAINTAINERS: Add doc files on real-time support to Real-time Linux

Sebastian Andrzej Siewior (1):
  Documentation: Add some hardware hints for real-time

 .../real-time/architecture-porting.rst        |   3 +-
 Documentation/core-api/real-time/hardware.rst | 132 ++++++++++++++++++
 Documentation/core-api/real-time/index.rst    |   1 +
 MAINTAINERS                                   |   1 +
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/real-time/hardware.rst

--=20
2.51.0

