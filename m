Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2D2417C2
	for <linux-rt-devel@lists.linux.dev>; Sun, 26 Oct 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520603; cv=none; b=BEe9EPVdcZg7pAG2206GngGMxI6nMRNlh8/dSLfWM7dKWZnKPC889CYSOeFmMfsE14orktn8IrBKZRAsSpZXv1SiwcMS+YNRL3wYS9osAiOX7AV+ExNCIiqoxnDekCnNcrFO0CeFGTdQXnrd2HfoFiDnmZvLAksHiaRmCCDFV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520603; c=relaxed/simple;
	bh=0/huNYjZWSix9nRszyI3WMM5CbL2Lg55WENfuAt+bTI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OEsOytUQ3T/cU7aA1C81rIcmMEU0gCMrKw6Ac6xqyIwPdLk4/vEngHFcUENxH30Tq+cA+kBLfqkXDzLWBLmNzvmRmlXCwVv62ekPgjWmzi5WLn1QrqLLSfnNYP/O0nqE5mIEh427opPmojDMzbTyYOzVvQa3YV2M5z4W8Pu5sRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcE11DJ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcE11DJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761520600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBWykJ+JLfTQQ7sPIXkhPYL39cPjNvStkhNiSczPsqE=;
	b=VcE11DJ+gXe/PSvjZJwGNxkP6UAoPMh4h0qQICYNCDOmE5dITNYl3p89XTmCaDvmN1kzzw
	4Fil+zQCE1x17OTe5D1fj+L+LdxKeAFLHWG03Fwz8NuWcoTgiBPBx31zuGYg5z7r0FZYyW
	rF2YB8ncs2NB2bgnPYYeB1mDVcnhpwM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-qgR75o30PDemOCdyDQdVMg-1; Sun, 26 Oct 2025 19:16:39 -0400
X-MC-Unique: qgR75o30PDemOCdyDQdVMg-1
X-Mimecast-MFC-AGG-ID: qgR75o30PDemOCdyDQdVMg_1761520599
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1558a74aso158983956d6.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 26 Oct 2025 16:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761520599; x=1762125399;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBWykJ+JLfTQQ7sPIXkhPYL39cPjNvStkhNiSczPsqE=;
        b=fLXGND5S5WOKgMYLU8zYrxpnhI4z2Dkv6tWmLq96G+iAbrJMLWLhTToQ7UC3MeR4mR
         ZEyx+hy1sbnWevznfT/3Ip/dTVYcwjD/Elhm1ARZQsTl0AEDcFkN0NgVv+0g22Tvy7ZN
         Ftff1RUY0Sr8Uf5lBALvVjiFKT14DJct+J4kTRC2+8e71EonWTiEBKqjnS0XOOHO3xOd
         SeNNM7BEYopSszdeCbApg2VnjFFyv1BMfgv2ww1fYfzIwScf85wCBClPEhHlAa7tk+v3
         Ok/iqpX5M1tz3I1qSV9GoxziiQL5LtvaKFRXaxmEqKa0vFxpcTdClQsW0M+SkRduaLnH
         Ab4w==
X-Forwarded-Encrypted: i=1; AJvYcCXk4iZIVOQ34yvgkZjsJ4cG0n8dwf55xFYp2WdbpoeZ2u7w37tT1H3aSpgIEgTtEijyxId0KrJ3UfIvY5XHcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS8S2oj9zvB0pITlThS/O2/81ko+EE5rNP9sn5LODxytMTFPXp
	6BILy+RtJa/LifJ3Bm5I7xmIVDODNH6uLFQFc7dxWsCEh00j3RFn5bAsrBwV2pVAStOUOmyTlts
	r29oItYZKhQS9ZdA533siSBGn3Nm1kcfApVTJyGxwqKZqIhcQH/eTJEZ0gOQ6/L2jR7qC
X-Gm-Gg: ASbGncuNCmkqmJxY+uwrFdG31UGf/epxkq3ALdKvaeyit1AP98mK2ndhsIouJFwjKAT
	6dF9nxn3q93Nh2qofqUMOiKaerAwFIXR7fatu8er7a6PKxpPvUgkPyTGj0T5aEjLqMHGmWfH0hh
	PvvQrX3aUiOZTJpdaGbEBcU4O6xpvWa/G+z5U3GzTbQ2XWV1ITDsn9THN2TJYhEDUKD0JuVASGN
	aQUUY1vgMREwsudzpYsQygurzcHyF6e2/vXsXiZ7pCTToI7n94RZiPYr9qIid+fMPnn2Zo35a+G
	2M9MQBbENYtsbBgdeq5gwQqlIawGyXzfOPCQ8w5ioCRjoJucPTuIR+Pj+dUYnRvJgFmBy07/MRn
	gILDwwYeRhqVbhxd/3woE03CV+9KRE4ycR0KRbg8irt0NmQ==
X-Received: by 2002:a05:6214:3010:b0:78f:4d53:7cd5 with SMTP id 6a1803df08f44-87c2055e413mr212351226d6.5.1761520598860;
        Sun, 26 Oct 2025 16:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUMbpyufTMcqOy5SlC0+mvXSrFqq3iNexFgoUnqdxkDBJdViCkPZAKJ8NUgAYACSCic30anA==
X-Received: by 2002:a05:6214:3010:b0:78f:4d53:7cd5 with SMTP id 6a1803df08f44-87c2055e413mr212350986d6.5.1761520598526;
        Sun, 26 Oct 2025 16:16:38 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49420absm39878736d6.33.2025.10.26.16.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 16:16:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <10579b1f-1005-4842-934f-0b9c6b65971d@redhat.com>
Date: Sun, 26 Oct 2025 19:16:36 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
In-Reply-To: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: II4dVehbSaQ-L0co3sui2HbtSPIIiQkDxSOlscIhr9g_1761520599
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/25 12:43 AM, Guangbo Cui wrote:
> This patch series addresses locking issues in the AER injection
> path under PREEMPT_RT.
>
> Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
> ---
> Changes in v3:
> - Remove unnecessary lock in aer_inject_exit.
> - Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/
>
> ---
> Guangbo Cui (2):
>    PCI/aer_inject: Convert inject_lock to raw_spinlock_t
>    PCI/aer_inject: Remove unnecessary lock in aer_inject_exit

You should reverse the patch ordering. Patch 2 should come first before 
the patch 1. Otherwise, applying just patch 1 without patch 2 will fail 
compilation.

Cheers,
Longman

>
>   drivers/pci/pcie/aer_inject.c | 33 +++++++++++++++------------------
>   1 file changed, 15 insertions(+), 18 deletions(-)
>

