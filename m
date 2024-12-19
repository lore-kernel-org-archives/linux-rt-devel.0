Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881EB1BF58
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734569625; cv=none; b=KPPBSkhuFv8cmS8jo2g5W9qfk/GRaxKwc05doqN3s28SSLxEgLCsOL97EB+Tu5AqWUZK80hTgoIxws3U2pOroRyr+jdSCnaSzmc0diFwde0XKqcJqR3BtaNIE/UrTWH65VC2V46qYfM/8i7bjorpaFrsr8vOszknizeoYmO4tB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734569625; c=relaxed/simple;
	bh=EOPeJWFKkfolyzIs32z2IuWWNI+wX1K+ZvhIv/b7oqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohEB0LlGQJ6IIEoVd4waMFeqPoUwYq1yw/AHCLxuQsOatGQ3QSo+YX74NogHjdZIKY1qpe4rcykARXHXZM2g6eavT2/TxDAaz+z8JB/Y+SXfYAVUVSly587sq81vtTdHedmH8twn3Xp9Q+sjBxcAGWMiSxDJnEmK6M9QAHv5pFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5hiQjtI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5hiQjtI"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728e3826211so246769b3a.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 16:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734569623; x=1735174423; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6P22t71eXplU/Scm9+lQUJ09MBJkdnAjgqbBSgYgXA=;
        b=T5hiQjtIUHqtyTZAk8u5AeITHUKCmWGlERF/RjzgLjGCoLPYlgGdI7f0RvjcBHV++M
         P5KyzAhP6Jmro7byFb+hU2YhUkOcHRiZMaIULr2r7tdUbPXOuAe/KX2X2HX4UxCjyZbp
         uvnpHczsB/wHkxJAw+BHTCAEo05A9bksmHudBbQ+23mCsM3h4/NGHZoMtNznLPRa2NU7
         eF7sOz3QXSMlOqzbaWQ3y4B58tW2CyxK1aUerbTZpaWqqZ1WYziURbqzMHn5jc6e2pDs
         KTf0+3bN0Synteoa4naL1SehgNjCz0V18DdV7VKN/jpmrINJ0gVi5PNlwqdPRpwuabJZ
         /h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734569623; x=1735174423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6P22t71eXplU/Scm9+lQUJ09MBJkdnAjgqbBSgYgXA=;
        b=B3mjAeC2MdB3A1DcJcRfFzLxGVPZxxCuzwInK8OdLqIJUVuskCZGYCTjWtLfDUWHBz
         3xbMAfXDyx410Xol+tSW3fg6WoYY38zSLJNpUzNsxvYJSrcI1qzspFm+2aHHbNfayXH2
         oxYmWCkimDVbSCCOcfCqBRO2g2MYYjkZ9wj73RED7LSgQhDl8aa2xbeBMb1VJWTfwdhZ
         e1zGPTnddp7GfZLJbgtPHnp7E4MWOSHJs8VtveSUNP3bGX5SNPz9t1tg96oDd82is966
         17/xEjI/g635Wxb+wexw7F0hbqMYPejxmTITnkLdtm41eHBW6P3qtUvHCZmI4y6G8OsY
         cx7g==
X-Forwarded-Encrypted: i=1; AJvYcCUWJj7OEG9zS1XxtxLlOFQbjjEh4jW/WFxq2tTemabCWXl1RSa2BphM1OQnJzw/JmJAZwXAaZxtLOHIp2lsJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrLZgRd86ISPeV2tBRtUm5qQRH7QSDUmpg46l/VplwVYVCR6pl
	w087FjYM//D0mnBleXscUWvQGOlcDrTyuJlYPyMRUaEo+6tZTSKP
X-Gm-Gg: ASbGncvg1kVhg3MQZ8loOGsiSrdKY9CVth41OgSnw6963fJxob+IJc/110EtM+SG+Sf
	mcgs2pQ+PlmMX2/d8QIZjctxDJQBd32rHv0kAQ6ZTE+oTuZHCeAcC0s6djkD+QckeZLrig5MUWh
	JuzLeatrQuxYnWoiWuuIMrbFhxY62pNXTOzXSW70ay9MkVNmY+kKlXWMl38CNzSHsaYjOXxpp1S
	EUlZxERnfauezTNjhtJHP7vkFySVyJD5JWXhuI0XwhufgVIcB2dR8ZGM5VSZxanAWk49RG9Jd4d
	LlTLvQGqUPNRxUKXIY3b1Tp0Mlo=
X-Google-Smtp-Source: AGHT+IGW38w6i0YeOQJj9ksqeHVscin8l0lI1gsV4DozSIxV5ul47YixHhCLAMwe/3+S8lF46QC73A==
X-Received: by 2002:a17:902:fc44:b0:216:4c88:d939 with SMTP id d9443c01a7336-218d724d4a4mr85947935ad.38.1734569622823;
        Wed, 18 Dec 2024 16:53:42 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca01965sm1376775ad.240.2024.12.18.16.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 16:53:42 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: lgoncalv@redhat.com,
	bigeasy@linutronix.de,
	kbusch@kernel.org
Cc: bhelgaas@google.com,
	jonathan.derrick@linux.dev,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com,
	robh@kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Thu, 19 Dec 2024 09:53:36 +0900
Message-Id: <20241219005336.8603-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z2L5u40lDvK7_Gdb@uudg.org>
References: <Z2L5u40lDvK7_Gdb@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

on Wed, 18 Dec 2024 13:35:07 -0300, Luis Claudio R. Goncalves wrote:
>On Wed, Dec 18, 2024 at 08:57:53AM -0700, Keith Busch wrote:
>> On Wed, Dec 18, 2024 at 04:48:38PM +0100, Sebastian Andrzej Siewior wrote:
>> > On 2024-12-18 08:36:54 [-0700], Keith Busch wrote:
>> > > On Wed, Dec 18, 2024 at 08:59:51PM +0900, Ryo Takakura wrote:
>> > > > PCI config access is locked with pci_lock which serializes
>> > > > pci_user/bus_write_config*() and pci_user/bus_read_config*().
>> > > > The subsequently invoked vmd_pci_write() and vmd_pci_read() are also
>> > > > serialized as they are only invoked by them respectively.
>> > > > 
>> > > > Remove cfg_lock which is taken by vmd_pci_write() and vmd_pci_read()
>> > > > for their serialization as its already serialized by pci_lock.
>> > > 
>> > > That's only true if CONFIG_PCI_LOCKLESS_CONFIG isn't set, so pci_lock
>> > > won't help with concurrent kernel config access in such a setup. I think
>> > > the previous change to raw lock proposal was the correct approach.
>> > 
>> > I overlooked that. Wouldn't it make sense to let the vmd driver select
>> > that option rather than adding/ having a lock for the same purpose?
>> 
>> The arch/x86/Kconfig always selects PCI_LOCKESS_CONFIG, so I don't think
>> the vmd driver can require it be turned off. Besides, no need to punish
>> all PCI access if only this device requires it be serialized.
>
>Sorry, I also missed that and induced Ryo Takakura to rewrite the patch.

My apologies I missed that as well.
I'll send the first version of the patch once again!

>Luis

Sincerely,
Ryo Takakura
