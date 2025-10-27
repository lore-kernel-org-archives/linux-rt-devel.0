Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609D2FF679
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Oct 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577815; cv=none; b=GBMzMNvlDvUzth4wRPr9jLwYIQIatDPVs/dugx+GZ6QCTK5cx3FD+ISSzr5omgMGiBNhzMJm8OptMFb/apDFngQCqCsYLstZRtANQOuKT5ln+iWghz3YFwCIengCHwNREbbTm9G+VCAnWWoJK3UHkeouESr7y/oCPJ3aQuYg48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577815; c=relaxed/simple;
	bh=P4gxh+sX4gDn50DCIKBIonCfr6GljY6Yg5PZOosv6Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlXC2YfHwGW63KrkIWs9DcQb5FPqo9o4PWFnQhr+9B23bPOhuKlOrVLXosA83erdPUiy/mQVhDxPyKcE+O4isWrxIK55PZ3Goyo5vX5u+Kkcb4hRhRcfLK/5Kze+Il1Pwf6uyelfgCXkfEwBWfVRqU5z8H7xeMKXTPt6pqGsO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQNr7YW5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQNr7YW5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290a3a4c7ecso53873615ad.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 27 Oct 2025 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577813; x=1762182613; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KV+dgU1xy8Q45LHOdAS8jfNYlLbRD459gKkW/4NsZBU=;
        b=IQNr7YW5+OxZX+IfzlaGgIXOLpCdejEs3GTbHh4qdD3YDK8HY5Qs5KDrdQfI59b86+
         VA8iXaxOWBxrqR7vBMe9Hz1h5n7zHb/jQkx+QJ/1G4g2VT4pVT32twgiusq+RFb9eQg8
         kp8cMl3IqkoOY/DkM0ARlTYzjg9aczH4bTe/40XwT/VCRwGVRI49WytVcVk88DOJ7FZP
         mAq+zkX0LsktZmKI7Ug+o86pl8xNj2y/KrUwOFDklTsdYSsWwTzygtWQhU7cQwJil97i
         Zl9hcoEg/APHJ4vxFyxmCrOfEO2LEHBklHOpNSM2QUG8li66BWQDARXCJwYMrzNRIhUv
         +UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577813; x=1762182613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV+dgU1xy8Q45LHOdAS8jfNYlLbRD459gKkW/4NsZBU=;
        b=W9Vuom1xXgnvHhehlje4WegNQI2mEDerPuMKsUsHEqoyDgMQ+U8d9d5v7Mr0W5NYlx
         uuyYJDPtDLqfoJ+jBPkxpfqyvMxumjP1ThGR8Nzqi6vmKd25/u5GkgbEOdZiGmBum2ck
         VQrMwT4TXIJDBAJbtBBfoZthJtKKtBLVwHF8/XQPa3x2St7xpRYGlk6IXkILZtP/CqHi
         cKiGnn2z9Ojc/fD1DL3EmWrSgUmqLLs8N+Q7cKARJViQyWXDvq5Y7onTrICOapyMsLsS
         er8kpROgWoG5GOCjOJu5sfBZRIUf6aoA9HNobIwj0q953GwgKCbtjyvPIeTnUgwqPZuv
         Y37w==
X-Forwarded-Encrypted: i=1; AJvYcCXbfGIKzxl1zskewUI+5fg5e0zGYt2aLokLGcVn9bz10hnq+BBs+SnZ0eOoZoW6Kacinq0Yc7oa8UtdXhQ9bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyxHGHLXcnAvupUBaEFh19KUXsonvRl4z9pVsUOdEJ0VabT55G
	68ic6ouA39E2nX0fI5G6KC9nSrVNP+joIjZlyVaynnyq962YYbr4q9O5
X-Gm-Gg: ASbGnctn4ubcHb/BaM7LGsrsiXn5nQKeuts+j7DV0hdkZm5ixIWxR6VK74HDIRtHZ7k
	8XlXu/8+64S9HZRXgIQFygHJqSQ7laFwTxdWmAa8wYMLfhIxReEULIGrL2qGZjWQJ4//XW7xH2K
	e7YuvsEIvbf9W4I5IMGJJEYU7mhzd+ZXGjqujI0I/Wo7EY0ULBoiyE2b+bL2RChlLJIyGrC4KJj
	4Th8QkTZjW0ai832qLji5AlpQNU+xeUK+B2h0HCSEeYft/m37hPm321bo75bGsWS4nPKeMBEVl2
	CjDEhagj7iu7sBBL4NN55a39q2QHLk6quoejpKpE2+12ad6kfss7eleqibiRIPyoHHrrbzeFa1D
	MQBc5DNKLyGCBg7OAPNuDgABRJ84UrgTDwkGLGVPXZRsjVeGm/8YenvpQLRjqWhwMYNXjm/s3Z9
	Uq2pt4UBuy9sz5Zn7VhMAvknafEl144O2KS7vV0ck1FsT+AW0p
X-Google-Smtp-Source: AGHT+IG2o9ZOMRiQToH4/Mv8njWDHz1vYKUsJvwR9D8DktGrc5VAjMxjT8KumWa3rz1I+qjC55ilOA==
X-Received: by 2002:a17:902:cecc:b0:276:842a:f9a7 with SMTP id d9443c01a7336-294cb523d54mr2795155ad.57.1761577813098;
        Mon, 27 Oct 2025 08:10:13 -0700 (PDT)
Received: from 2a2a0ba7cec8 ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2333fsm84223145ad.50.2025.10.27.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:10:12 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:10:07 +0000
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
Message-ID: <aP-LT-IgxbZMdWNt@2a2a0ba7cec8>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
 <10579b1f-1005-4842-934f-0b9c6b65971d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10579b1f-1005-4842-934f-0b9c6b65971d@redhat.com>

On Sun, Oct 26, 2025 at 07:16:36PM -0400, Waiman Long wrote:
> On 10/26/25 12:43 AM, Guangbo Cui wrote:
> > This patch series addresses locking issues in the AER injection
> > path under PREEMPT_RT.
> > 
> > Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
> > ---
> > Changes in v3:
> > - Remove unnecessary lock in aer_inject_exit.
> > - Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/
> > 
> > ---
> > Guangbo Cui (2):
> >    PCI/aer_inject: Convert inject_lock to raw_spinlock_t
> >    PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
> 
> You should reverse the patch ordering. Patch 2 should come first before the
> patch 1. Otherwise, applying just patch 1 without patch 2 will fail
> compilation.

will fix next version.

Best regards,
Guangbo
