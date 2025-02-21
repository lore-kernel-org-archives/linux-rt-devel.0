Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4944502F
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Feb 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100680; cv=none; b=m5V8bTPCDRzN+/VoFLMO78XoFKEuZ3j/xvgugZ2Tec8UII25LiwmBMtK+qktfrJC70JuXCK1QhK9W0kFHSxavhiGcxiXGCulAJ7IUZbDF0bVzaxjJg3PF4HXMr9aZODwsy7opuOWuqb4Dp9uL0mJ6Rcp7o3++j0A4ULGBqXENgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100680; c=relaxed/simple;
	bh=w/wHhqZ60M2rVKS74re1Ys5b3Nn7e/itXBY5RYwCdUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRhAN6IPQmpYh3jvKmkrSDpGSboOvl7m2PomW3Kez6Ta6DXzYKKENLASTNonoGcLeXpibMJoX4HasHHlaqFnu5pTvrVal+EmeOs15j4UvVZOnpaVHoiFiC/RuU0GAI3LgEDh/Wz8LKM9zbWm9ctJFn7rEjcNhwAqf4gtJN4SpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e6028214so34962555ad.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 17:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100678; x=1740705478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRDnaSQYuA7AXNjVck19mgs0g9VBHJmey8gvy5+nRVQ=;
        b=WIqntU4Feh5G3ER5YHn5Uv6gZ3z4a1jsJ/sXL4BVta2NaWh599KsLV7L9KNrSYepGQ
         1JbsZQgxmuCEQaZMjw2ErMK/ymkeSzq92ZPcapec0gG3gwUhysxmLn3oggER/pO6cc4A
         kaXiuKvPwcT51g/74uZibvxl8MKY8Vo2VMTz56OIEbE1+wFjfYSO8NI/exd5j7EYMPWg
         nDAJc4OmeA4QmZU6U+yMv57JxVenw7HnqDcEDtCiXT323DUdhV3vfkqUa7CixA5RkA1x
         IcyR5Y1/XqNkDk+Z6jt6qitxb9HjiGB5gNPYbKWrPfuPZgkPR7S4y5JoWQsFxXFCR9Ir
         5Org==
X-Forwarded-Encrypted: i=1; AJvYcCVSnVdPr9tcYfSW0SkKH6B9xRQL4QjiHnC/wDtGisCirLmSsnqJC9fzUVf9YyRwtXPsmb5473emGqiS/oCtkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yycg8pH32hzuilKE9W7qxl/cuU6AtnYcPcMux3P6Ve0GSC0Hhty
	Ng4Px+0b4ZCUJfMA3awrOvmDAs/V1+XVjyxYRvMETNjI2UDg6C1M
X-Gm-Gg: ASbGncvV5By2A4/g+O8snoHu4E/Z60j+b3v7hLcZJpmciBXDLGmJhlVdWaMvfHhF/Pp
	+Fc21tbfr6XE1yFPdrQLa9fdBgMQacRRpMJCBrmcMVprM+8LMpLKe/fKVWcW3Hk82enG8U9UBf2
	uJu0ULV1dhfWTiMPaOiqACPtC7ovXUJ95vka4AYdXWLmrlHqPcxL2LmxVkSe9ZWmunI0Eusju91
	QExMRsuM+MHUXpoORyaT6NOgza7Aq/BhfObFppJtAdGoXpDK5oGmNbwLQTPuW/CtRAZLWXpNGBG
	iwaYbnTDrou3Q/wp/SVkRVO/Q0HSvlvRWkp6tMUpQEso1XAgyw==
X-Google-Smtp-Source: AGHT+IHLcykA8fts8RT8gddOQgn2Exio4nrAweQFXPHSKIaj6lxr07hzXrGZs2H+GOTF69rjVciZJA==
X-Received: by 2002:a17:902:d484:b0:21f:164d:93fa with SMTP id d9443c01a7336-2219ff82783mr15228375ad.6.1740100678359;
        Thu, 20 Feb 2025 17:17:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d559830bsm125343855ad.252.2025.02.20.17.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:17:57 -0800 (PST)
Date: Fri, 21 Feb 2025 10:17:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-pci@vger.kernel.org,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ryo Takakura <ryotkkr98@gmail.com>, bhelgaas@google.com,
	jonathan.derrick@linux.dev, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, nirmal.patel@linux.intel.com,
	robh@kernel.org, rostedt@goodmis.org, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t.
Message-ID: <20250221011754.GE2510987@rocinante>
References: <20250218080830.ufw3IgyX@linutronix.de>
 <20250220225948.GA318342@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220225948.GA318342@bhelgaas>

Hello,

> > The access to the PCI config space via pci_ops::read and pci_ops::write
> > is a low-level hardware access. The functions can be accessed with
> > disabled interrupts even on PREEMPT_RT. The pci_lock has been made a
> > raw_spinlock_t for this purpose. A spinlock_t becomes a sleeping lock on
> > PREEMPT_RT can not be acquired with disabled interrupts.
> 
> I think this is missing a word or two and should say:
> 
>   A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
>   acquired with disabled interrupts.

I changed the commit log directly on the relevant branch.  Thank you!

	Krzysztof
