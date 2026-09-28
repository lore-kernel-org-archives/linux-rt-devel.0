Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF12FB0B2
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.199
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599514; cv=pass; b=qJKzpBLJRuSfS+VKh4gq/zZrNc+MAVHHprp9nH3Sq5p8t3JRZww4FlSvmeuwtFQDpoXbU23oSJw86wAqmp+JAG4UJHWgpuSVxFAR8RTqy9NQO3lJM8V+LxPfBKHDRWInc73q8S3ER5+yWQJ+rteGi2imNSQH3sY1c97CKCvwWds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599514; c=relaxed/simple;
	bh=uml54LJdPXLb9Lj9vOwlme7Ptb7ND54ckXVmhxSLoVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJPTZB7/obUidwLfgP4ZqeTm9veTML2GpB6GUNEPsTuZM8sljg91SHfh+TxVgMCVhvrONCvpSvl8FQRFIuNlRMvgpPkhKACN2K+xDLEXLuM1HXWh1CqCa+2W9qk7zxUYL4BZ1xIcXqE6lAKUEreELdQ1wqXipbC8USPEZuGKhyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmKNMctW; arc=pass smtp.client-ip=74.125.231.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmKNMctW"
Received: by mail-oi2-f7.google.com with SMTP id 5614622812f47-4b39374fab5so1052195b6e.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 05:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790599511; cv=none;
        d=google.com; s=arc-20260327;
        b=NmShUz7pdnSBob0+NTznMt4d6BMSbOsJGdW8a7BY93+7ggm4KuT5hWLLplkHBZFwmS
         idqsCOCFIxZJcbBRHiEXoF8WdFYzJ0pIxPjnhKXb2GIw3W16Z8KXv6+x/A+GP8t1SCvB
         UQaabFxJFwmcfBHav5DWw+a3QksJ+8UpdGd/pRPYFyXAF2EbSfxNLOjYB/8469DVO+N/
         70ZgULHidNfuomk/q60CQoducPGws0GHBggD0KlsbT9Lvk1DI2PIyEbgKz8gO+dJrak/
         IZR/uOzRuBhsv5v97NH8QbzvWUAfpA7Q7M/SZhf8r5nU1LP8IrcfwHhonTuTbBLEsfYK
         523w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uml54LJdPXLb9Lj9vOwlme7Ptb7ND54ckXVmhxSLoVg=;
        fh=/81MKPF6XZkGTCHZxqisqmHzQrcmn+eloDvaK8/xgJ4=;
        b=OFXmrk2lHIT5+yvMGs6PafXFwHnF5ghcZNS7n26T6gs+C7FSZupIUbIiiOylIKe7an
         qJ0Y3QLi8muEMceGUN8m2PhvsJZE5hciRSjLJLjdZjZLNYGOokzseTwhAQcILx8rCNw5
         gq4pYMyOdjlw0b2HUiqZBz07VmhmpyLVxNyrj79yatncdi/r3hZweLRoESmtP8L9RaiO
         anmuxuAq9Ux/vmarDuYgB9oqe3wG3xxVrHpqSJvz1j4oq1kIm5Ba0q8U8YdoDUgZnc3X
         1yv4xAYIba4noybIEBCZyGsw7rzKdSPLop6jibga2uiWrvUDjz/WwSGLgpYDDhsgTVa5
         P5HA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790599511; x=1791204311; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uml54LJdPXLb9Lj9vOwlme7Ptb7ND54ckXVmhxSLoVg=;
        b=RmKNMctWsI0MVfjjz84zE9WEC3LgARDca+7Zc+KYVstdaLvn2m5shTt/X86SHv4W7G
         jyBIMwPfKKlKq3GVFz9gdeB8CyAvqHa5DYepp74cbh1NWCaMxiL59H1iJQrTnEQuEkGo
         e21BagVfLEtwrunzNExHMMd0pZr0yAoBrJSbeRENGNnl6m8U9re9OLh71TYJVGs1kkAh
         rCSamtGzjBeoPnoYLGj/MPu9EWWsGPc8/rW+/NQy08HPObSltNJ0dYUX3Chf0DQ6ZoAZ
         87I9vksywqTvRhCUeEmLhzLS6rATiVnJUS/FZqsMr9PGp9cAQnvFIeWjZb/yKHOaFKs4
         xzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599511; x=1791204311;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uml54LJdPXLb9Lj9vOwlme7Ptb7ND54ckXVmhxSLoVg=;
        b=WU0l4Oa2nNVd4YCpjiY4qLvVnZtbCP0xwVmRcKyk0mu525z6VKvJPkKnJSKW97T8D9
         AsYGzAYD3IzLWb65sHhoecUBjSOzKHWqQAsfIDcrUvrfuoRWF4h2q3kYcLoqeyH7vuo7
         F5Ms/rqPcvwnjVphQgk51qBrEFfHJxUhW5boeq7awRGtkqfyH2ngy5L2Scve3AxkEQzc
         lEGZdvNRpj4HkDbk742ziXJm1j7mdNKSq/5e611eNR0Paf44+e5zJN6xRUgGfYsx1cQz
         t8M/9dCkzm5jkB/L9zK5y0jSKwWc+FZ9pfv8rHnp4Xm63Uhqgg5cFQDFYEZnIVHhz2D+
         xdsQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5D5fS3cW7FddKiVBdrRokmluN75CltASNtEr5QQZUGJzb/PnddjC/8PK12JuKH8aiMokDR6zeB+PFuZqtBQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m0y58mpWLNlqC6tMOAHug/aNRV0EkacoOi2oRCfHhvO2yFELTl
	aigOofg1PNzmcpZ6WezSFW6ilFkitqnF00D06+5ePtc/czYEJvTEP61oVOWrM4epo3l4+eFVe0f
	ADj4Iqd5hGXCkx/aTPr09b2KMGANqrx0=
X-Gm-Gg: AYBFou2J6L6BcoSRRfzi/sJR0gxi0C3T//aCAOaWqGIr11zEd9MeTilZzUbpY1CGj3r
	pZx+I57ndTkhqzOXi/XyFj/fbgGLQjmkARQmAIc2RCkP6ws9NWdgVdgf6G1HcaFd31yYbK6mJDe
	Bq0VbomLuvpNVvE0fuk0v5YApNQDt5nGkS7RaSec5X8vSUu7FIcTFJuPMSGIMAJ0mq0SjfhHJmL
	fw5ldGtMdyaz1kccEBn/zgvqiihC5X4PhpmtNEK6N/fZv+c5d4NhmbOQLJagLlgcnE8lDhdkVU6
	8XZqRorS0kPoZ+sDg7Osc5CNB6B0cd41mjV8yCJTj5skb9Vxkx35kC+FhNv00THN6SCGRGJXekI
	M1Pu3cUsk2+GEUhw3lDF5
X-Received: by 2002:a05:6808:4f2a:b0:4e8:92e5:db3b with SMTP id
 5614622812f47-4e8930466c9mr5061632b6e.35.1790599511413; Mon, 28 Sep 2026
 05:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
 <CANOyQmGkGwSkwUj-NOKzhQ_mgapoqqoOLaqXaGAjWK8jiknarQ@mail.gmail.com> <20260928122822.JdtAHH3g@linutronix.de>
In-Reply-To: <20260928122822.JdtAHH3g@linutronix.de>
From: Jason Mike <jm5905938@gmail.com>
Date: Mon, 28 Sep 2026 20:44:59 +0800
X-Gm-Features: AclHuK85xEilyaFEaA6Ff-fETSVKq3q1FX0B6TRO8Aa1XTtbukC6Oiy0wX_0q1I
Message-ID: <CANOyQmGkfZs8z2fcDa0fN508MV2aahvq4Gg41BCxUOeMqCLONg@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: picolcd: Move output requests out of spinlocked sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On 2026-09-28 14:28:22 +0200, Sebastian Andrzej Siewior wrote:

> This is not limited to PREEMPT_RT.

Right, thanks for the correction. PREEMPT_RT was only the configuration
where I reproduced and tested the issue; the bug itself is not
PREEMPT_RT-specific.

> picolcd_data::lock. The important part is that the lock is a spinlock_t.
> Non-PREEMPT_RT builds should complain here, too.

Agreed. I'll update the commit message in v2 to make that explicit.
Thanks,
Aveline
