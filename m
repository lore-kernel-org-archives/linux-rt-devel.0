Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D58BEE
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734569747; cv=none; b=kG3AfajvmIYsqi3b+fClimrhdOMFIWpgx0K2117zwa9rg1ZL9hvE66XMJkZb5+jOt5OazJXx32WUHdfUl1n9NX81/f2YdiTyuo+AK0pW+oeX0kuKXKBYnf/pRbd2dG++gq8qZ6Z8WsMmkSYGiVwVzYfKPFZnc6LflM/m5c2d3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734569747; c=relaxed/simple;
	bh=hd0ZlzWgSawFh8+8A+rV7uc3ocDRTNeUduIba2FQg1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+MX5H7HG838BMJCg9dg5pZZx/SlpbvWPfW6Ng0w9sSBuP6eKY9Yj/LbMMb7UaLp1Ikp49iutSo1JUrQ8FriyVWMHgHhYbTzC6sXm4Th8QkABizncUqp3dFSydLGxq0GGCtXSlUTcISs40tHK1wMdyu/JrkKbqvM4+axxM27t20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/74lsaW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/74lsaW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21619108a6bso1975185ad.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 16:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734569745; x=1735174545; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z2JJA+VVWbDFlxfMN+TCjx2RUrp/JrvgBtYLZGV9fQ=;
        b=N/74lsaWcgfc5SMyKoYtcQbvNo41swGCbQ0YsgT5KpMdaWeCZ/HHGq2EU2EEoyTs4r
         Sce7RgmS8FUYVrwMKlw9wX/rJN+QOeLVzqNg1JRsNVXaMVzmBWaNBUPkUe5cPg8Ftp3P
         i/zKoFTVWu+sK3scl11TafryhhZsowCdU6z9MJ7Ji3X4/A2wRZ2dkzGIhRownhRWU05T
         JrK1oTlp3HXUDWNayiNhznzmVYrogRR/jM6CA/LQbPg8r0wR8Ip7UNZAqZhABzoT5D9M
         6nS1jURv93LzxBscqMpOecBUnTBlh+A2Mxa70Q2xGPe+KptT8KWSlZGH2jY1c/bzZCCX
         p/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734569745; x=1735174545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z2JJA+VVWbDFlxfMN+TCjx2RUrp/JrvgBtYLZGV9fQ=;
        b=Rh1WN8QiL32J41utVWDB/L0sEyI4v1wASTKM7MyLfZfxt4AvJvIPPdrFRG5yGlfE2B
         hjv6uUaj1uXtvi3XHE+CAMdwZWRMucXzN5iQsBaOmIP70W0otJsnm1/wEXhD6m/N+z1G
         m6SEimr2aX81ifi4OLvcOdOr+roLveLbkwH2i239DlH6e+/kGR0mZStsUbmEv/AGYEyb
         vDdl485Xb5GQVO/pSKVqcmFF+3DXg1bnX2rHi3tDq26kPq0aY8jKsDNQk3PjdEPnqGMl
         UWo0BZwa1/X4D3G5GJgq2s8lBAdnv+bKtHlksKPl/N5MhtFUcEqOLM+F7cnOFi+bhmjq
         QCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfjiPsDRsWfK3/9ynin2sUIMzIddFibOSaGD92N2YXWeIBB64Ha9SpW6f2+ftlCTrWTrXWrWSBzgt1AO/lQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcYYJ2KVV3YgHs2xywVmavsBPtvOtpK3DRUJFwgoCbxnN1qpWp
	cNNj3w7dscJqoOGg43cf1lhr2ZZCj5TgnWfZhAH2NDmIxvX+YbYt
X-Gm-Gg: ASbGncvY0l8GxNuqhA1qEqJBO7fik8CYzHNKbd5kExH41cf5DameF69iZe/aH6hMY9N
	fqcCrwQrNH74DNcVrb/n9MwRrtVwx/eRi6ldrZn32X2phWkcaagvqUutBv3eL3XSgTQnw3PcckL
	Uwhxq7MIhRsPC6mUDrvk6h7zLg9gZs8VsdrnrS9d3YfdTaMvwarDkGlSBQh8Xi2M2yOX6KnYgGQ
	sIsEqgFTqK/QvJHGQI3KyDRVepeFhvxPwotGWjd2MGffM3Qh+CxwVNoKWcvFa9W1dsZP7/PrCox
	SjMxO6HFCIC3BNoIokM00ikiB8I=
X-Google-Smtp-Source: AGHT+IFvQC912dfQQj+RYYrtFJJbdM4bKFikCtfL5Crx1hXDf1k/rw3oosC5thpRzFx/YnswfK/uTw==
X-Received: by 2002:a17:902:ce8c:b0:216:7ee9:220b with SMTP id d9443c01a7336-219d96268a0mr23576035ad.22.1734569745167;
        Wed, 18 Dec 2024 16:55:45 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e867sm1482065ad.71.2024.12.18.16.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 16:55:44 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: kbusch@kernel.org
Cc: bhelgaas@google.com,
	bigeasy@linutronix.de,
	jonathan.derrick@linux.dev,
	kw@linux.com,
	lgoncalv@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com,
	robh@kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Thu, 19 Dec 2024 09:55:38 +0900
Message-Id: <20241219005538.9125-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z2LsFoXotl_SHmNk@kbusch-mbp.dhcp.thefacebook.com>
References: <Z2LsFoXotl_SHmNk@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Keith,

On Wed, 18 Dec 2024 08:36:54 -0700, Keith Busch wrote:
>> @@ -385,13 +384,11 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>>  {
>>  	struct vmd_dev *vmd = vmd_from_bus(bus);
>>  	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
>> -	unsigned long flags;
>>  	int ret = 0;
>>  
>>  	if (!addr)
>>  		return -EFAULT;
>>  
>> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
>>  	switch (len) {
>>  	case 1:
>>  		*value = readb(addr);
>
>There's a comment above this function explaining the need for the lock,
>which doesn't make a lot of sense after this patch.

Thanks for pointing it out! It slipped my mind.
I'll leave it as it is for the next patch :)

Sincerely,
Ryo Takakura
