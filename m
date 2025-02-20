Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD44175D50
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063092; cv=none; b=kHculQ7hgf3ceArVJuO4yjcquoYIjdQx2hjasBat/gMBN1B0spByplP1doHwHKKx0gSqNaeegFjCbFZqKH6WLiuoDaczG+NxOgNfSH7EuL4Pxc9sxeMQN8mAcZDMRO6lX6cho+VfombJhxYC0olQt18F1MxRsed0OvEsU4yKxqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063092; c=relaxed/simple;
	bh=YigPOSx0FrxVDFzK4Q5gUpQLHMc9FWJmNy+x9rZcy94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1HvVP45BjL3PouMohT8IUq0M8hWf43qXMRaFIkO+cHHhMVkmQCN5u8waVCWHJ8joLMfLF86O9v2ZSeWyuBFqQtlcqgElOvU9kAJxJGLnfrMRF72PqCAZ/ZYBpzlFYOLjictt+7NHuwpgqMfNf3WvNw/Gij4z30gmBy6WZI+oP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2211cd4463cso21126685ad.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 06:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063090; x=1740667890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jy3mQRgRVU2vUxlwRfGBxBzH68yyELG5OxStWqTTWqQ=;
        b=au2mFsKO+pRnX+YjhKOqmu0Vr/eoyQPGyuZZZSmT2jBAxSKR/yFiD6oHzYf/Bjk7EG
         e9rq2XZ+TBxJ5U85z8/QLih2f31Q55wRr3tnstgy9S9dowJnJLdgwO9Xal6eWuDX2bBV
         X7f9FGcDrMf9/BDRws1ILCjcg5bHmNgkMYRPrdlLL6tTJhTnneDh7IvELXqAXFTsl6d1
         auytoPL1Fu4P2kZEDf4AhRwsnsUITLy9E8BLBsF/AiEaSdpPijjVRUyH+xJhbuaBnwkf
         flp8ynSRwe/sreknKIXygCRZ8EqKpmM8KCkAT8fII7Mdq840fycymi3Qwj6URYzHZKZx
         fLmA==
X-Forwarded-Encrypted: i=1; AJvYcCXDX0E8crqwes7GeGD88OT4VX/5xTv/CPdA2C5TMUfIusV+uZuViYnbL2EPD2AneXBa9RZuIfve6d40bkhOaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMAffeRDuBSnMJFg0Uq0DGDtm6ZRndOYix+UCG70L0zQIhTUFa
	HglxTu5WA++IpV7Q2ngB01goIbB4iI01HgWL9GbKAGmd3XHGWFM5
X-Gm-Gg: ASbGnctMwRT/4a5eXOfLCl7jYHAvMijFUF10q/etg2HJy1CtuV3yUg/K7KbLWPx9eCd
	vVQ2ul0KsxiQ/JBRkhMu4ynrCa179Rp16m3DukabtqLyKu7xWgx//PnWM/Wj1XtjNa8wsoxvl68
	ViRBlmN8pz2swCrchSn84XomWi1xySEI9z9zZroT4ENdrqsRk9t1xBkspXz4LtvtAXS7v8wCt4L
	PLstyODs5v5GOMvcDF6aMSdhSk73hSKb9M2FFzEesnzA2fyweIazE/A+DPXNICBQVHsIjQzLsxC
	mgRW6DkTLwF/q8w5g/iQ+0FFS4GjlhWNSqEyZ4UC7PQPNzH/mQ==
X-Google-Smtp-Source: AGHT+IEQvdJF7vSBVcv1qxen8l5KSJTg9fuwK9R95HWCV8z1yT8iLSfyq53xyqcofBz+BzQGYlcC/Q==
X-Received: by 2002:a05:6a20:cd8f:b0:1ee:e0ad:e6e9 with SMTP id adf61e73a8af0-1eee0ade943mr8776240637.14.1740063090006;
        Thu, 20 Feb 2025 06:51:30 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73284a7401dsm7194066b3a.134.2025.02.20.06.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:51:29 -0800 (PST)
Date: Thu, 20 Feb 2025 23:51:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pci@vger.kernel.org,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ryo Takakura <ryotkkr98@gmail.com>, bhelgaas@google.com,
	jonathan.derrick@linux.dev, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, nirmal.patel@linux.intel.com,
	robh@kernel.org, rostedt@goodmis.org, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t.
Message-ID: <20250220145127.GC1777078@rocinante>
References: <20250218080830.ufw3IgyX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218080830.ufw3IgyX@linutronix.de>

Hello,

> The access to the PCI config space via pci_ops::read and pci_ops::write
> is a low-level hardware access. The functions can be accessed with
> disabled interrupts even on PREEMPT_RT. The pci_lock has been made a
> raw_spinlock_t for this purpose. A spinlock_t becomes a sleeping lock on
> PREEMPT_RT can not be acquired with disabled interrupts.
> The vmd_dev::cfg_lock is accessed in the same context as the pci_lock.
> 
> Make vmd_dev::cfg_lock a raw_spinlock_t.

Applied to controller/vmd, thank you!

	Krzysztof
