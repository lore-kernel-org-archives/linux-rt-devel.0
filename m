Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CA243361
	for <linux-rt-devel@lists.linux.dev>; Tue, 18 Feb 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887677; cv=none; b=JQo2uYP9onXMQnaSv7QuW5Kua74kFQ8HqFye2qTpcixYZeMUtD95iJ/BrAD+g/joa15VW6krgDjpFSKk18FcHGk/Bp11w5SK1wMO/DGDjKWU2bvkpu6fZoYh7ZWhU28a0AI05CH/ksMP9H/SBvPbycRL/Z0muLUuY6rx0gbZ1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887677; c=relaxed/simple;
	bh=FNvj8sCueTrxfOtK1bE8HaMBcrhFqMBwyCdDzbGaNRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oj9Xb9tlt4eL1+Mg7Dd4Fr9gpufktvyHy5ZF0LPaUDN9FzzQNK5jU0Z5op1qR+Mz7sUuhytPSTq21x2BEBbK52imztd6uoCddQwjH6euri6MFwKMSBMBKI+jFEwuIg1XzIt4OIs3qm143dk2dXRguLRPhVyhSgsRjrjGrPI8kyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlAjyKIF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlAjyKIF"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so7540965a91.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 18 Feb 2025 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739887675; x=1740492475; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAc3ks8m7sc7B4PDBh8P097QzbrGCXimimGuS9OzNkc=;
        b=hlAjyKIFYTJazsEiXoDjVK4Yfmhf7lzbvWEIX0+iE/zbaso7gdGuL0ZfDFhVtneyEX
         JDKr2EajLmWGrceX1m+pg2ISesH34WSIXfj7ZUQWBlQ428aaa56wio5Wz4/OQeL3n40p
         i75jZXf8S/nUPzEsJKdXrNwmU1m3PGSQ0mH17luqA0GU7imh7pxsVfUvk1za5e5MffkR
         C9dB3KdUnaTUNK7J8YLODa7QM0dyFW2ecSa1jDby0EG/B0cQiFcfdzL/xGsqoUCbOnCE
         LICJ2+Dz5Zvmzlfq7h7YXW95eVaOfuocVIuYgv57ThodAwNTEwzx7Z36lIWUJB3N52KV
         RWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887675; x=1740492475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAc3ks8m7sc7B4PDBh8P097QzbrGCXimimGuS9OzNkc=;
        b=uRkwU5NW3maIk3lUOE06n+RVU2AzWiak59O2KeIp/QnK84l+2wLnBxh1ickVLU3rCg
         H9+uNGTPcaI+Ol8mZVKFbFHacTJm/1Yqa17PWTOOTANmUmwcpmq/ilqm8iKs+kF4aAU1
         LIzx9ffLMLN1Q8wHS5Yss3rVX9XgEkVWXEHGZ7vT7wSiWi2x7wvlIfQIGB5htNDy/PCu
         umA7/LXULpEXEr02HRJcUJ7mDGCNwprxDRrCZsZII73LK7LFqaxWIM0yuS3gnuchsaVj
         +1mTxeJ924e45DVLCFu8wK7KByqssrq1nv8azMmLDiSL7j74jU92v1ad/dVrf7hpgwbj
         OGsg==
X-Forwarded-Encrypted: i=1; AJvYcCWk/MTkTOCfd8EcHTFl/tj4MY3LPCbgn7nNA1NOtNjV2q4DlIplHN5taRcBj/Xa5qtGTQZzBXKCHYegSVIUlg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg/TeW36NyecA9v9ieqHNlDkGTJBku3R1ESjzC8Dpz4dwz9tuE
	QFofJVPIyxL9ORQFdojceJLvDnyRCHPLZlhqzTMxAB4ohSgMc44r
X-Gm-Gg: ASbGncvPKbuAIOEIhLDdRw9LpWH7RwgODfVPm8+qZ913nOZxqGObaEjp9cvmzsc55+b
	PvXa5B2RJE2wnwKuqPbb60Wzhf1wfwb9kVb/qjI4S8ShG9NtgFsdrW47MsRdtWoZzV7r+BALpq+
	1gpllXEPICH4aqtAwoe4VuOaqOynfUJfssbx4m69m593wKGHnFi4PZkTXB3QsLg3wYoROPQlKEc
	no/5O9+XiMFSYEnTngx0lR3kXY8b50MWENzLdFACQikGo7FN5jpxXyzxmTw0RRUr4QGjl+qwtsO
	B7IZHyIuGecw2Ueo8+ZWN80VxuIA6fJHwSQxJ88cbZWa+ozVwjfInEtM6M1MB3qBVqW2riXeWtG
	SX1pfPS9CtaV0
X-Google-Smtp-Source: AGHT+IFPN68wS30Nt8EqquCKHrPPdtzyNgfnZN8Uy0UGUn+srQLGItB26KLP3BnWcgivH+bNyazbLQ==
X-Received: by 2002:a17:90b:35c9:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2fc40f1076emr22333960a91.13.1739887674823;
        Tue, 18 Feb 2025 06:07:54 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13bbeec8sm10037888a91.49.2025.02.18.06.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:07:54 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: bigeasy@linutronix.de,
	lgoncalv@redhat.com
Cc: bhelgaas@google.com,
	jonathan.derrick@linux.dev,
	kbusch@kernel.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com,
	robh@kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v3] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Tue, 18 Feb 2025 23:07:45 +0900
Message-Id: <20250218140745.16065-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218080934.IRRZ6B6h@linutronix.de>
References: <20250218080934.IRRZ6B6h@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luis and Sebastian,

Thanks for checking in.

On Tue, 18 Feb 2025 09:09:34 +0100, Sebastian Andrzej Siewior wrote:
>On 2025-02-17 13:50:37 [-0300], Luis Claudio R. Goncalves wrote:
>> On Thu, Dec 19, 2024 at 10:45:49AM +0900, Ryo Takakura wrote:
>> > PCI config access is locked with pci_lock which is raw_spinlock.
>> > Convert cfg_lock to raw_spinlock so that the lock usage is consistent
>> > for RT kernel.
>> 
>> Any movement here?
>
>Reposted as https://lore.kernel.org/all/20250218080830.ufw3IgyX@linutronix.de

Thanks for the update!

Sincerely,
Ryo Takakura
