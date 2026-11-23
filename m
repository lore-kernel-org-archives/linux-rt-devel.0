Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438990;
	b=HPchpI2Mk6L/m909UdYLV/3EcENDUKCSVg7vmND9Q1KoH7R9jfMgnkpSQtmlIXo/X3eJ
	 WQbw8WDq7XPl/ie3WmrPNB587CcDNMt2Z1laePWa3M+2zH+S7TSWV12c+YotpCxR8E+Wj
	 3dFt/whTizWk9Qg0Vo7mU/cvZP+5RnP0cnYAjNn8bnty6B8hegEdVts6hldv7SNHMxH8x
	 hOhyJnrddRqpMONZhhFz5KEpXPxj7puZ6Bbhz8T40KidkddQpxwYSzEBWm3lsXoPTBQMJ
	 3FbH0rmhvRvNISWJPqFFvx2/VAE0F4zP4z3m2Ht8MBXDvcZyPtBR6/iE9z9yYDRGjoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=DXYfjHMF7j6k0mtN3BH/w8d4nc907qjO+zSnG7azIAw=;
	b=VCDE55LxbddqH7rVyvfMtHsnbCCUd4caRINxm+zWDy/MDxBmcr1Rdk1xf7CEh3Q9cn24
	 s8wms0jQ5kNZqaMRsfAOega4X1svCzSL2AdegBbngackO0zo47aWLezM3tt1yt4pM8tCS
	 Ug5heeRtAbz+1PklCxy6VOCuaxZInK2k4M5Lq9KyRXLgVZDaynkFwg0QrGoVmy6/waY2q
	 VcoRp0LFmWbPoLOPTqzVHtNmJ0ZgPy13YhEzFuw6NvIbBi6Sv/IJkuRWWSku7aYlw6pnK
	 Yh0graGBLAREcIe6XIsEEAl76apHT4uoiB2WXko5lmWmALcwx3FNLymp8n8+ySTIq9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sUnNJqKU;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FE606A321
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 13:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F9FE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sUnNJqKU
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c515319dd89so361255766b.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 05:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795438988; x=1796043788; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DXYfjHMF7j6k0mtN3BH/w8d4nc907qjO+zSnG7azIAw=;
        b=sUnNJqKUV6ZO5Zy6HW7iBeewi82EYnKRZwXUvt/pmePi40R4B+ui7NTpElo1yhOcBV
         kzgj1RCaxqXg3d6W9LO3Tjja+cnmTzAs09BBYVXFK/RXOrhAP/pIsK8S0JCiIf9tnD4c
         krS/7kKVKcdT0rF9rId2/yOdkJVVAAhvSi40DDDLqt2Q2ClUKhShnbn6xTzq0Z53oyMh
         E4/6BeM7KYMoBIBFx6kmGmIZZjuJBG/3C1JmOxFtlFEsg0iSw8C4Hj91mGJSMjx0pXfy
         Cvp1azL5dzYT6CDg13UMfpG1eF7LV99n5T3xaz5uPD9Vnrvw8GRCT3wM4s67OGapwPcU
         dIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438988; x=1796043788;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DXYfjHMF7j6k0mtN3BH/w8d4nc907qjO+zSnG7azIAw=;
        b=PtByGJYEvCc64p/FnWndBPfettdsmlq912vmBvC1RWsLjfQp/sbcTpOkJ4UpfBOfk8
         IxawPtrjax3TIwpQPRa5qEADky8EB729WTqalbz1nnVmWBB3B5tt7FC8ib9w9w/ny33x
         jKfufolSAPTOpAoJs2BmoXavugFO0lYIJkVE1sDKF4xg0oQQexdl9xzg75XO2fAebKj0
         XXzUKjAIXEN8GdIAO8kEG21hH2rfr0vZFASVsx80eQviEPF97IHYAhyOa2ISR1Q8GTiu
         oCzS1kb0e3LEeeuGu3TKjOAWNPOoYAWoBENIVw79Pq/2xMmyffZLUjIMqhzH8MdC2bJq
         8g/g==
X-Forwarded-Encrypted: i=1; AL+hErGztFZ//NoMmqxIdC7MupKvcabYkufIp9E8QYAe20o4jssQ6kDGcjeHrJ5DkJJFYewwEVkciUrAkr8WEjjYGw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Kg/0/2bEzErJRMekKgJtdW60hx4oh4mTuSDyQN/hTjiuZ0bUq
	+ej/xg0Rfut8FtE0C/gqMfLHQ4+VaMy8k3K+bvJ4XYqhPTj2E2kdexd2dM9oUhtHIcs=
X-Gm-Gg: AZFdTZfJpz24nqEsE284J8lpvwW/f5D6680qszuTkSUiNp5wRT7mfQb8O5eoxC+Zjj6
	w+xuQX10RfQwJvKN+wY94qHDco5f3xPjldfyEjxf3qst4nZL1e7wvybN0seAbiV+GFyv+HbN0cs
	7fMEGVKV2/aU4Py/bk3D+Z/uAEe3JZRAyP+oTt2eXGcTM/uRd6kV7Wj2R0LNj26wrF429Sl0MHM
	69WkQT1shp1L+bEHRKbmISlHw1k/ke8mKNeAHGqN9B/taW1QBBCiINX0CyJWVRfXKDgm468TK1D
	LT0DG5IZdkBHTWMCm7zFa+NJbJFOxmjtD1xy4hYA5fuNUkQcXYndJLSncik5HlgONx2OZKURQQ6
	h8p1n/WbVwCN/HxxJxYTzMLMVUMAfSWfhqx9EseM0kowwUS9mFLl51ZgIvyLxRzp4WHX2myOWiz
	IQY0GoYBvfFOYw1d0FNIluypHZupZcV29o4n94RUTedNBbDo7ntoh0YxLV3TnY1iI0pJqycAT2x
	niqm9zkX65dCbXc9ysbpO22o+YRZOB1rfiR4V9SQFgj3FZlxSm6RgliWUtBd7ms1Eek5q2iw5Cp
	xUuV711lArw+hNH4iIVqjCo/pBpwkQRDdp3sjPJOON4qUTsk6Vszyifwp6WTeViiZSnOARr/h4U
	HnreVJ3UAz71GUDfiyvdO5g/62TlTHBrM35x2Rmg=
X-Received: by 2002:a17:907:a890:b0:c41:55b4:d88b with SMTP id a640c23a62f3a-c513ab14402mr997167466b.43.1795438988469;
        Mon, 23 Nov 2026 05:03:08 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85ecsm401379466b.70.2026.11.23.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:03:08 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/2] usb: typec: tcpm/tcpci_maxim: lockdep and PM wakeup
 fixes
Date: Mon, 23 Nov 2026 13:03:05 +0000
Message-Id: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAIk5BGsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNj3dzECnNzc1NL3fLEzBJdQwNLc5M0k2RjQ6MUJaCegqLUtMwKsHn
 RsbW1AKjieAtfAAAA
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

These two patches fix a lockdep invalid wait context splat and a
probe/unbind wakeup-event race in the Maxim 77759 TCPCI driver:

- Call pm_wakeup_event() from the threaded IRQ handler instead of the
  hard IRQ handler (the driver uses IRQF_ONESHOT, so the primary handler
  runs in hard IRQ context even on PREEMPT_RT).
- Initialise device wakeup before requesting the IRQ, so a pending alert
  or an interrupt during unbind cannot miss recording a wakeup event.

Tested on Pixel 6 (Oriole) with CONFIG_PROVE_RAW_LOCK_NESTING=y enabled.

Cheers
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (2):
      usb: typec: tcpm/tcpci_maxim: fix invalid wait context
      usb: typec: tcpm/tcpci_maxim: init wakeup before irq

 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)
---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261123-max77759-wait-10974f4c312d

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

