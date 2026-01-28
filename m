Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E329A9E9
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594147; cv=none; b=fPRrTX9bXWz7ecCykimSAo0RfCUj3liV+SDdIFCYU1b01CqL4foyo+Juv8Oo2N298fCROC1y6wiAt6WP6a5bc7S1KJgKEJNK6E1oy5K8CtG9nbvqCf9Okc9wCmxasacUL+T/+tNfr+68d1UWhhNjMO1vkD6GzmNm0sfQqp3W4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594147; c=relaxed/simple;
	bh=km8Ahc/MMkc/aYy4nz+bLJQvHGsgiiDvFk0DT0PjfZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwaNzKN7QslGKArUqjLXcQNzOibIHegYFY6qjxJMppCcEkzVq68p+dOcxoTN1vYkG5WiaBcJQj3zpgt7aZQMlq7UNPXLNYXCpKyUNfOkrGRpLK4xpSm4pgTLmKbj1zoJh9e4Wo/biERbUoiQ+dXtUXt9rfuSeVTzDekANuX+ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gmW0n+/1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXZSL2qD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gmW0n+/1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXZSL2qD"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y3iiP5umwIGAWEVpcZv6AA7nUq0StKGLGovsBxUrDro=;
	b=gmW0n+/1bguXn3LPVLYJaggbo7V7vvqHgu5fqMH/3MsvdFtxECScpMIn7hE1TmK/ww0VIB
	gmwpBNpkYo7kAoWgRShLbxEvUU6442Kgpr0oGe6nMV+sS084d/t7q/TDyywiZyf2V50ieR
	o1Z6gyZFcak8IK3dUMnC4SIk1XRULxNdnLi9aHBLVbidglLrRIy9nR95Do7hEhqavbVE0v
	qtVW2Fmf+49XBMrvDH1TD+Q3lWIsIgB0DANvRWYHLu35B85B3kt7qQ4cpZUpj4TFBYwfhR
	+1wDWJV/wb3iEl/BSVgpx4pvGLT2amPkuUpfG8YDOtc2j52Va6yb5cnRcGre/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y3iiP5umwIGAWEVpcZv6AA7nUq0StKGLGovsBxUrDro=;
	b=zXZSL2qDxzsCvLZMgVEN//MZejucYnxK7/7zvlL0SVFC1Hh+ZcK1jvzZamcs+FL4Ay2we8
	q9rk8qiy/m90vSCw==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-devel@lists.linux.dev,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>,
	"Amit Kucheria" <amitk@kernel.org>,
	"Andi Shyti" <andi.shyti@kernel.org>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	"Andy Shevchenko" <andy@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"Daniel Lezcano" <daniel.lezcano@linaro.org>,
	"David Lechner" <dlechner@baylibre.com>,
	"Dinh Nguyen" <dinguyen@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Gustavo Silva" <gustavograzs@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	"Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Ioana Ciornei" <ioana.ciornei@nxp.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Jarkko Sakkinen" <jarkko@kernel.org>,
	"Jaroslav Kysela" <perex@perex.cz>,
	"Jason Gunthorpe" <jgg@ziepe.ca>,
	"Jassi Brar" <jassisinghbrar@gmail.com>,
	"Joerg Roedel" <joro@8bytes.org>,
	"Jonathan Cameron" <jic23@kernel.org>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>,
	"Kent Gustavsson" <kent@minoris.se>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	"Lee Jones" <lee@kernel.org>,
	"Liam Girdwood" <lgirdwood@gmail.com>,
	"Linus Walleij" <linusw@kernel.org>,
	"Liviu Dudau" <liviu.dudau@arm.com>,
	"Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	"Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"Lukasz Luba" <lukasz.luba@arm.com>,
	"Marcel Holtmann" <marcel@holtmann.org>,
	"Marcelo Schmitt" <marcelo.schmitt@analog.com>,
	"Marcus Folkesson" <marcus.folkesson@gmail.com>,
	"Mark Brown" <broonie@kernel.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Martin Tuma" <martin.tuma@digiteqautomotive.com>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	"Michael Hennerich" <Michael.Hennerich@analog.com>,
	"Nishant Malpani" <nish.malpani25@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Oder Chiou" <oder_chiou@realtek.com>,
	"Peter Huewe" <peterhuewe@gmx.de>,
	"Puranjay Mohan" <puranjay@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Ram Vegesna" <ram.vegesna@broadcom.com>,
	"Sudeep Holla" <sudeep.holla@arm.com>,
	"Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
	"Takashi Iwai" <tiwai@suse.com>,
	"Thara Gopinath" <thara.gopinath@gmail.com>,
	"Tony Luck" <tony.luck@intel.com>,
	"Troy Mitchell" <troy.mitchell@linux.spacemit.com>,
	"Will Deacon" <will@kernel.org>,
	"Xianwei Zhao" <xianwei.zhao@amlogic.com>,
	"Yiting Deng" <yiting.deng@amlogic.com>,
	"Yixun Lan" <dlan@gentoo.org>,
	"Zhang Rui" <rui.zhang@intel.com>
Subject: [PATCH v2 00/20] IRQF_ONESHOT clean up
Date: Wed, 28 Jan 2026 10:55:20 +0100
Message-ID: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

There was a bug report about setting IRQF_ONESHOT where it should have
not been set. I looked around for other mistakes in that area. There are
the following categories:

- Using custom primary irq handler doing exactly what=20=20
  irq_default_primary_handler() does

- Not using IRQF_ONESHOT but it looks like it is needed

- Using IRQF_ONESHOT but it looks like it should not have been used

- Using IRQF_ONESHOT but IRQF_NO_THREAD should be used

The outcome varies from harmless to problematic. Some examples:
- Missing IRQF_ONESHOT for a threaded interrupt.
  For level-typed interrupts it is essential to disable the interrupt
  while the thread is running in order to make progress. Missing it
  means the interrupt remains active and the thread has little chance to
  make progress.
  The irq-core will reject such request_irq() invocations but only if
  the primary handler is NULL, not if it is a copy of the default
  handler.

- Using IRQF_ONESHOT for a non-threaded interrupt.
  This makes no sense since the threaded handler is missing. It can
  lead to errors in forced-threaded environments such as PREEMPT_RT
  especially if the handler uses functions which can sleep only on
  PREEMPT_RT.

This series is touching multiple subsystems. Instead of sending many
single patches I decided to make one series. It would be nice if the
individual subsystems could apply the changes individually, there are no
dependencies as far as I can tell (except for int0002 but this is a
different story).

v1=E2=80=A6v2: https://lore.kernel.org/all/20260123113708.416727-1-bigeasy@=
linutronix.de/
  - iio
   - Splitted replacement of ad7766_irq() in its own patch (David
     Lechner)
   - Swapped the ordering of some flags, missing re-idents and a few
     other things to make it look nicer (Andy Shevchenko)
  - picked up tags and dropped applied patches

Sebastian Andrzej Siewior (20):
  genirq: Set IRQF_COND_ONESHOT in devm_request_irq().
  platform/x86: int0002: Remove IRQF_ONESHOT from request_irq()
  iommu/amd: Use core's primary handler and set IRQF_ONESHOT
  mailbox: bcm-ferxrm-mailbox: Use default primary handler
  bus: fsl-mc: Use default primary handler
  Bluetooth: btintel_pcie: Use IRQF_ONESHOT and default primary handler
  scsi: efct: Use IRQF_ONESHOT and default primary handler
  ARM: versatile: Remove IRQF_ONESHOT
  char: tpm: cr50: Remove IRQF_ONESHOT
  EDAC/altera: Remove IRQF_ONESHOT
  usb: typec: fusb302: Remove IRQF_ONESHOT
  rtc: amlogic-a4: Remove IRQF_ONESHOT
  thermal/qcom/lmh: Replace IRQF_ONESHOT with IRQF_NO_THREAD
  perf/cxlpmu: Replace IRQF_ONESHOT with IRQF_NO_THREAD
  mfd: wm8350-core: Use IRQF_ONESHOT
  iio: Use IRQF_NO_THREAD
  iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
  iio: magnetometer: Remove IRQF_ONESHOT
  iio: adc: ad7766: Use iio_trigger_generic_data_rdy_poll()
  media: pci: mg4b: Use IRQF_NO_THREAD

 arch/arm/mach-versatile/spc.c              |  4 ++--
 drivers/bluetooth/btintel_pcie.c           |  9 ++-------
 drivers/bus/fsl-mc/dprc-driver.c           | 13 +------------
 drivers/char/tpm/tpm_tis_i2c_cr50.c        |  3 +--
 drivers/char/tpm/tpm_tis_spi_cr50.c        |  2 +-
 drivers/edac/altera_edac.c                 | 11 ++++-------
 drivers/iio/accel/adxl355_core.c           |  5 ++---
 drivers/iio/accel/adxl372.c                |  9 ++++-----
 drivers/iio/accel/bma180.c                 |  5 +++--
 drivers/iio/accel/mxc4005.c                | 11 ++++-------
 drivers/iio/accel/stk8ba50.c               | 11 ++++-------
 drivers/iio/adc/ad4170-4.c                 |  2 +-
 drivers/iio/adc/ad7766.c                   | 10 ++--------
 drivers/iio/adc/ad7768-1.c                 |  5 ++---
 drivers/iio/adc/ad7779.c                   |  2 +-
 drivers/iio/adc/mcp3911.c                  |  2 +-
 drivers/iio/adc/ti-ads131e08.c             |  2 +-
 drivers/iio/chemical/ens160_core.c         |  9 +++------
 drivers/iio/gyro/adxrs290.c                |  2 +-
 drivers/iio/gyro/itg3200_buffer.c          |  8 +++-----
 drivers/iio/health/afe4403.c               |  9 ++++-----
 drivers/iio/health/afe4404.c               |  9 ++++-----
 drivers/iio/light/si1145.c                 |  2 +-
 drivers/iio/magnetometer/ak8975.c          |  2 +-
 drivers/iio/magnetometer/bmc150_magn.c     |  9 +++------
 drivers/iio/pressure/dlhl60d.c             |  7 +++----
 drivers/iio/temperature/tmp006.c           | 10 ++++------
 drivers/iommu/amd/amd_iommu.h              |  1 -
 drivers/iommu/amd/init.c                   | 12 ++++--------
 drivers/iommu/amd/iommu.c                  |  5 -----
 drivers/mailbox/bcm-flexrm-mailbox.c       | 14 ++------------
 drivers/media/pci/mgb4/mgb4_trigger.c      |  2 +-
 drivers/perf/cxl_pmu.c                     |  2 +-
 drivers/platform/x86/intel/int0002_vgpio.c |  4 ++--
 drivers/rtc/rtc-amlogic-a4.c               |  2 +-
 drivers/scsi/elx/efct/efct_driver.c        |  8 +-------
 drivers/thermal/qcom/lmh.c                 |  2 +-
 drivers/usb/typec/tcpm/fusb302.c           |  3 +--
 include/linux/interrupt.h                  |  2 +-
 include/linux/mfd/wm8350/core.h            |  2 +-
 40 files changed, 79 insertions(+), 153 deletions(-)

--=20
2.51.0
