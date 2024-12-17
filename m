Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E11DAC95
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Dec 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423774; cv=none; b=rORn2++j6pm9NPgDkIpbs83iGl9z3HM6gsuVL7iYKxSb12oTPDtPwGfntrlix3ow17bCgWZ+DtWwjUuvUD4RA34PjkG3WrLnovXEJx0oaZcvFKGfpeVcEPAx5iPFb3raWa91DzEpHQ3Oy2O1gzoXyo0d33BVHv8Z0Usw2DVWkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423774; c=relaxed/simple;
	bh=sl89bj/6/Z+mOrYSKIEKRE5nQqIUbFo3iEpWNxCKxNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mut7UnEHhpOZppkmzoUV7/GsHpdEQ1rc2qNXyQ96I2E/gmaHHySnN3XD+8eK3p9Z74hIqkJiKC7xmn+50kfwgr0a+KMla6aydqQkQxykCQmJnhDYD+hRGKb8dzomUOg7rPiFXBYiTcWXzJ05ldQ+IhN1KTFi13EX9dopBnt+vJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USl7NbLW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USl7NbLW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21619108a6bso37336235ad.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Dec 2024 00:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734423772; x=1735028572; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4SJHwVm7jGqzHklwEpE/hT2jIFLI2Cr/r40yccH3v0=;
        b=USl7NbLW4QUiuNk32qJEnzh1dTtSAgRTwkicAFI/QKfTZZfWLOiJosZXEeIDCK/EWY
         wYDup39JT2CtqS5GmLFTPJtOT6OtM77eLCqqV4nXDZ5OfTh1UzLzBBWeOsTvIVcWnv6f
         XCieAvsnN8S8Job+HC+OTEObZgGQrzy6XZyn+r8M33m6mOTt5pMIaDSehiYYM+qwgKgm
         7GQmkkRa1MEmQ77ZUwhGxIRDk125nXDN7J4NpISiPqAWeLGMelP5c5dyc3dPR7CdvsNc
         QWYwp0RovML0VCj+3tzDke7ZSx+Dgx3yWRIJNU0iFfFimR253hT5j11nhqbO2fJ7fRVw
         RBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734423772; x=1735028572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4SJHwVm7jGqzHklwEpE/hT2jIFLI2Cr/r40yccH3v0=;
        b=H41WrwvzKvMXq88gl4/5nn8XsDPTYaXl1sh/Ue+HUSzeNDd252Nlqyz+l06XNtpnXm
         geSYA6QAPHFcabhu7ND0MVA6mgkkoaSygpOQcp29vDHwQh0xcbEo0G5R8drGYkiFPQJT
         /puYGlJT2x1I8lEIxijyruA11vFFRrk8Qy4OcG7qv0TDVReQ7C4bN+UTQe8ZuW9rQP1n
         Ou4+rLtCZUE4quLV3av7ZlpkqIivZ9q2blSJoFn/Z4ymvAvaC0LStmiCUbkmJWH9YK0j
         tGPoMVL8RwOKHrAezgVLy5Lu3mPKH/6skwEF/iccxvw6WAD6HLlERksgjkxgOWgWEllD
         ZnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRBLvyux7SvHE6mIzlg9UseWF65vJp6iO+dP6BpCaddOyH/rZLcguIOmBQ4VtKBPD1HFn18E7miycCSTLp7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwScbalyh0386k0KZy+vVouKfFC/mYgXd5Hw64Q3mDit+IpgRUg
	HFoOxij3NdKFV/NGuLup7zf4hmDnnj3RE7IEMhqVZqgw/BNMJQwc
X-Gm-Gg: ASbGncvHmzZhM49WtvwUey22KvtJe7Vj9yrvWFlvUAIl5CDe9I3sXs8OrYFJFv7IJ5q
	pyUQ8AUV+3cRKOyngwB2Una7PAI8ILDhXLICWcbinJj9T+2zIg8lMs2et/zdCKRkDGnOdopWm8I
	0pz2gueRpfJs9YXkgqV0maD5NjHN5v2H7L4dKvRbXYEVwdFhSavPRaSXtm56EXBvvaL3YkMekqS
	7EkelhVDARqLUZMYV3MSf383hHwgb//9+pspZV3xx6k7qgVsH+f2bibX0c0JnbeB7bILnBUwCWr
	adrsTtZsKAS+PFDjebgdnsqid6o=
X-Google-Smtp-Source: AGHT+IGtSoyIcGbzwmPUa/naySzySQJyzxPj6rq5R3+shBbBdUyu7Hiij+fD+Rip/wOHzEC6OmFH8w==
X-Received: by 2002:a17:903:22c2:b0:215:8809:b3b7 with SMTP id d9443c01a7336-2189298227cmr195617705ad.7.1734423772455;
        Tue, 17 Dec 2024 00:22:52 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6416csm54419255ad.230.2024.12.17.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:22:52 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: lgoncalv@redhat.com
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
	rostedt@goodmis.org,
	bigeasy@linutronix.de
Subject: Re: [PATCH] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Tue, 17 Dec 2024 17:22:45 +0900
Message-Id: <20241217082245.12514-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z2A6VEMN5jkXg2lr@uudg.org>
References: <Z2A6VEMN5jkXg2lr@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luis,

On Mon, 16 Dec 2024 11:33:56 -0300, Luis Claudio R. Goncalves wrote:
>On Sun, Dec 15, 2024 at 11:13:21PM +0900, Ryo Takakura wrote:
>> PCI config access is locked with pci_lock which is raw_spinlock.
>> Convert cfg_lock to raw_spinlock so that the lock usage is consistent
>> for RT kernel.
>> 
>> Reported as following:
>> [   18.756807] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> [   18.756810] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1617, name: nodedev-init
>> [   18.756810] preempt_count: 1, expected: 0
>> [   18.756811] RCU nest depth: 0, expected: 0
>> [   18.756811] INFO: lockdep is turned off.
>> [   18.756812] irq event stamp: 0
>
>This problem has been discussed in the past at:
>
>    [PATCH v6.4-rc5-rt4] rt: vmd: make cfg_lock a raw spinlock
>    https://lore.kernel.org/linux-rt-users/20230608210232.056e731f@gandalf.local.home/T/#t
>
>And there was a suggestion to remove the lock altogether as (at the time) the
>only two call sites of vmd_pci_read() were already protected by pci_lock.
>
>I wrote the patch removing the lock and it worked as expected, but never
>sent it to the list. If you think that for the current code that makes
>sense, please have fun removing the lock. :)

I see, thanks for the link!
I took a look at current the code and I think that cfg_lock can still
safely be removed as explained by Sebastian [0].
I'll send another patch shortly!

>Best regards,
>Luis

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/linux-rt-users/20230620154434.MosrzRUh@linutronix.de/
