Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609030;
	b=fCe5fZJQGQ3XsXJZO2t6MGdad0IGbYFIZPDg5bGkx27ggc49ZczErnGH25SDllk1aTLh
	 A8EtMXF8szXClrDbl25DRHpxR5gpMaMNMA+7OLI9qVOGCBJ9ZT6EKpA6bjdUJPkxKU0P3
	 Hj7cFnPWpp6C55tZ2+9OvWxFcoaVzqdwDHw7RT6rK0N7lhzNfpd4kZGP51dVo4COEePBL
	 MR9rYzku7tbF3iNDkqJX9kYVpHnzpmoJbLUJVSXzRSKUp/CiQwNHqX/3wFZFcReq3ZZ3x
	 wU9IS6vQ6AndioEL5US2cS4w4gtwzAABvyBk2ZEWB71VX1KKvhjnNtb0jGkKp/DEs7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=0HU6I5cV1alAqBz4EUOEAXse6J/R1fjd0fGE1Ycjrz8=;
	b=nEUyyEU+I4d5hZnsfLppzCyU/NpJIzMtjkg51MrDiKpHK11YWxgSvVzMzt1O1xDzq1yl
	 AbbD+YB4XaR1krUvU7O5VP9/QUkgD5XO+uMgSFMWjxGldiZCb/Jh3KDz5+aY2wzN0GH5A
	 zXiaQZlW3z/wfkNeh+t5fzpw1/UgQWTvuX2U1AocaThmKpoBoVhV0h708ZCGP1FpfOfRH
	 cqey0gkNI920Hpxk/djr8e0GMH7nnnQquY26fuCjt3Kx+wW4SmiMFBC6i99ErASSgAjYk
	 q3+YZCsPJpn3zZ1Cp5vaYdYJKsWHftLxEYjNRhKEYcmjpN6F98th4T/kh+6dRy3fMMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y21T15BE;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F12606A32C
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 12:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F12606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y21T15BE
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50933bdf4bso1093610366b.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 04:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795609028; x=1796213828; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0HU6I5cV1alAqBz4EUOEAXse6J/R1fjd0fGE1Ycjrz8=;
        b=Y21T15BEBFTOZ2fJbPWmn5l6eTrNrkp8tIw68oj9dzClkdp67hroxC9QoFRwD0qLSe
         yq4eeK81p2lHudSOgITbhDZh27ydshhDA54MsvDhgsztfp2n+G8FPAbObMx1mRfO8KyI
         4qRgky61SH1zYL+O6wO/cvj/yRXAeM9iWnkHxC0oNECeAl50LpTZvowhPglCDrRRXqF4
         QK7elwwgOREAPrQEoeDt6Y0hMJ/xyTJgghTJV0jlX4cYCErqFuqDD+ysxkHtX3s2pXYX
         PLb/Dhl/L/eIkp18Onr2gJIsrIf8byh9Hq3E0ZrAD0rHfgH/seeLTWtIKZs+TiVZDOMa
         E6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609028; x=1796213828;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0HU6I5cV1alAqBz4EUOEAXse6J/R1fjd0fGE1Ycjrz8=;
        b=ovVZOYwfNwZmPndDeZWLCjvMyyRwdG1lx26xpRLhseD2V7/3zVLvKE33RHONKmccNN
         vlwu5xgr4vbCdnMMa/KCo+0qHNvvRhmZmKdbrgx9QYseIIMZG7UnGFsAdPTxBDLzchDe
         8zL6wBgVXAIIA59pkqovjQVVnRDsgncsFIVWY0klfjC6zyy2Covwf5pmQCWPapwzj7sK
         jIYDPcLEbA9BAoNPVI73Q+kmIsIuAqjLq7EZc/Wi7O6ylvLnQJfpsRPa2WlU0Rr2YX7R
         gVyiXHIoSqcwh/MBcPkn867U26fq7n1+eGHVmBBKiYob6A/bPl8Wk0NgpLTIMR0qsmsd
         biRA==
X-Forwarded-Encrypted: i=1; AL+hErG6xDpXIHxD8pbIXLHNQQt94f6VB5diucKX6uy9LAr6OPf/+uFaPmiIDkvXZqbF4I6dVuSixDknEbPBr80Nsg==@lists.linux.dev
X-Gm-Message-State: APuU4Z99Wsczb96mg12bggtgX8Z1rbbfGD6iollWFUHECvVauAKZuZbT
	iGEsSWjUfMmBdEuPJkPUBqO8eVj705bx1HJ4L7ixWUfRGd0vnQNl08Y16vahGSrT674=
X-Gm-Gg: AZFdTZd43FWE56sFjCzGkhO1/FWrEwMr33A9bhmadxGJJHaUNcruRVBanEV7FdtgYrA
	AqNAVSgNpmewHRbrKPNDrIOmRIMGkt9IIwMUxNbfnp264zENeOhliCiUIb9f9SJIQGI0Yy5geu3
	4pv90oUjQF0EuTmCy7iAJ3U8RbDjDQTO7NLqydPXKozIUObKKvAfLOKmUxO073paG7lnuqPZfQH
	2AQICkdedtAOlQjqK477lQp2DL1gsx8ukOI2PBJIG044pWEz/+Dror++jSc8hi6B0/cacg/dD6K
	ElNU8lVkkAnRxXrEy67NQJ2dmMpHNmFMpdYg0lTFi2xHFQ9EtIdWrp8Wt8PkolgO3lTmQl9hqGK
	hvfc19z2rO2OV0vxllT7seIzbEkmCDe7CdEu0YMb1z1YNyozfnCqXiLKihtjRPDAyCVl9MlLJrE
	BFbRwAmHbHk5BZR1iCidJJmCmzfOvPdaB26U96rHEFlV3E2GH1FDUz92TiQ+sRVzTLGdOrdRrBt
	spRc3ZXl1alEgmhKdcfDMJofW2808pswALIDmr1yYw8kwsEFiLaNZKEUdCriStWMr0BckO+WtCc
	UNFsACc1b+sQR1lgJVOOIWJ/3d3888YMBrWt1vOqiDSBgxePPTjU2iAQzZgBYsrEjUXHY0zc+GZ
	gUdRqgXTPeK2BRhz3nQ==
X-Received: by 2002:a17:907:ec09:b0:c2d:c6e7:9e9a with SMTP id a640c23a62f3a-c513a816ce5mr1420780966b.11.1795609027961;
        Wed, 25 Nov 2026 04:17:07 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm650611966b.3.2026.11.25.04.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:17:07 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/4] usb: typec: tcpm/tcpci_maxim: lockdep, wakeup and
 vbus regulator fixes
Date: Wed, 25 Nov 2026 12:16:54 +0000
Message-Id: <20261125-max77759-wait-v2-0-9914b985c00b@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIALbRBmsC/3XMQQ6DIBCF4auYWZeGQZDYVe/RuEAFnaQVA4baG
 O5e6r7L/yXvOyDaQDbCrTog2ESR/FJCXCoYZrNMltFYGgQXDaKo2cvsWmvVsrehjSFvtXRyqFG
 MUD5rsI7203t0pWeKmw+fk0/4W/9JCRlnjTNKGq2w7/X9SYsJ/urDBF3O+QuicADZqwAAAA==
X-Change-ID: 20261123-max77759-wait-10974f4c312d
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Hi,

These four patches fix a lockdep invalid wait context splat, a
probe/unbind wakeup-event race, and two vbus regulator lifetime and
logging bugs in the Maxim 77759 TCPCI driver:

- Call pm_wakeup_event() from the threaded IRQ handler instead of the
  hard IRQ handler (the driver uses IRQF_ONESHOT, so the primary handler
  runs in hard IRQ context even on PREEMPT_RT).
- Initialise device wakeup before requesting the IRQ, so a pending alert
  or an interrupt during unbind cannot miss recording a wakeup event.
- Fix a vbus regulator use-after-free on driver unbind.
- Drop an irrelevant error message when VBUS sourcing is not requested.

Tested on Pixel 6 (Oriole) with CONFIG_PROVE_RAW_LOCK_NESTING=y enabled,
including tcpci_maxim module unload and reload cycles.

Cheers
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- add patches for two more issues, a UAF and a spurious irrelevant
  warning
- collect Heikki's Acked-by on patches 1 and 2.
- rebase onto next-20261123.
- Link to v1: https://lore.kernel.org/r/20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org

---
André Draszik (4):
      usb: typec: tcpm/tcpci_maxim: fix invalid wait context
      usb: typec: tcpm/tcpci_maxim: init wakeup before irq
      usb: typec: tcpm/tcpci_maxim: fix vbus regulator UAF on unbind
      usb: typec: tcpm/tcpci_maxim: only complain about vbus when sourcing

 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 62 +++++++++++++++++--------------
 1 file changed, 35 insertions(+), 27 deletions(-)
---
base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
change-id: 20261123-max77759-wait-10974f4c312d

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

