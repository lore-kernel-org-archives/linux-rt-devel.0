Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1A2F39BE
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Feb 2026 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534437; cv=none; b=EmH8wX5rxM8W4fH4uyGD1T5V7PVRRHS183GcOuCO+MR9ruIlrns8+3abZv3xnr6HlPiCRv6IL4Dj+WLYzWA7SH6AfPCQKD10R922Xy1W5cFABP1xHilK/XmAAAGjQmbty/JZzdZ1JQlT3XGZLL+JYaEeihmtcp4PpZwyFy/KaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534437; c=relaxed/simple;
	bh=VtkUeQqIv+CKGsGDvlaBg8MMo+vbgD0f5XqDruqtBvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhfmRU1uQersbcajl+8rEwedONf7mVyQunW34GGONBrnuMtI9cX0kIcTXX1z5PWjUZWC9SHmAfBcqKPWjK0U5FDxTpW311+EwtzLiugl6Gl8OeFGax12HtX3XPZnxR+akZijNFagHGbAeDTVe4+PYuuQ23C4EQuBQiiR1LOP27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Z2yV2Bqy; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Z2yV2Bqy"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-127380532eeso1227865c88.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Feb 2026 12:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1771534435; x=1772139235; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+0jtUmFu2xonLSRE9SPenU3HPWTK/ilL6bYMdfeREs=;
        b=Z2yV2Bqy2wGp1PkVw5YrIPFeLN7tSSmIlW7dWlyksk8AnLfqaqc0CBywiXzE2Pz1/P
         0p3vOpi1VTlgXBLmAuDUOBr2rkLCkScspxulP40cbJkVEdorbS1P28xTVHga51M+md7p
         7fqcKSa5OH4QeJ3GJjMxjxkI5DBpqM+PRXPxdaMy2/kIKe5OudVk1BzPykarjVJjwpFz
         ihEIN0FSTcBTV7e0XHnXdBhpXxldYqoMk1xeaQGJzum3IxWrTFZAckiQRvEBP+iQSXcj
         z4WGgytDT9asBwYzBNUdeEiLrQs3F+uEsgHsg04yU+rffHM7XPfeQ8sWeU14gkX2RBup
         Icdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771534435; x=1772139235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+0jtUmFu2xonLSRE9SPenU3HPWTK/ilL6bYMdfeREs=;
        b=jmyvYyrTUmmeLTTj4wU+3x5GPcqn2jGh+pceX6tt1cM/AUqnT091Lrlj5ueF7Bjjh7
         IgzNiF/lM/i7BzfnH0UeuUwnMR2qqtXBggSt89AoNqYJNyhugaSGerpmVChp2d8lwb1x
         03YHpweJ0HUVauqRNWtGKS9kgqY/vysTDluLxQ0P9q42HnPbWBWhacde2NpTwryGOt9Q
         gEzpDuZ31I73KTYdBXd0o6+67za0gzskHZgBwsZVl+jATGy99sHpb0WovN+La2USJpBT
         4TBNc69oph1ocZURpKYziD/AcbjtFjVMh5cLQAP5B/ddjqUIByV4BTZ96sHZN8aPVgXW
         IGiA==
X-Forwarded-Encrypted: i=1; AJvYcCXAW/Ss9BQuOQlCW2Fvxs5WYzr09zY+P3tCRbNWN9b7hLtibzJYDU1BZBuRDPKsRojU39SRVSHdKSSgCOvgwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDqTG26CIfC3InaJSDqnyBmN0elb+ILAER4RVw8KNxaLbD68A3
	7B8aGo17FJoxdG12XdLU3rwUUwPj1MEa1603O0/sb1Kfn1UO+17uiRiJbLUaGipBKaA=
X-Gm-Gg: AZuq6aKnLmZxv8Ceaz5nZKJDN5F/NICPjTuM8Gs2qoCRIhKJFEGXqlutNqJAJCjR4AG
	2gp5LzAKDPMnN7ECTjMyNUlfoDmeuDv2gObiC+g9zebCyjIHzEOVI/+dudUC8zBLIj97K9eAgid
	mbyPylLi8MXBKQNVm48ItK3vcwSPnItpgys5yMPcu4LZZm4KBb2/e05Pj3n1NwtVG5SyhNT0LTg
	JxYHK3GhP8NJfyYlY38zhCuSVXAuwSpr9+YdMz3XWgJTz3aoaEZ4RN97qTqiNjOoYEQcG0uB6wf
	4VaIJg3tJ87Cjh7N3/vlv9MnVgwEULXNu6m0+lhlAGHVRbLFyZGlPiq+GdepznocRIFU2Nn+VEf
	/rqrvWIGU3x6i6uGIKMWIl+Uwmk0CnqDX6UeBjg9zFhoyZNyvMMc5Whoh+ccw0RWx9Wfo2f8RYd
	nrqjovHchiQusul1QoFU7tw6bBlQ==
X-Received: by 2002:a05:7022:2524:b0:119:e56b:c745 with SMTP id a92af1059eb24-12759a100abmr3035797c88.10.1771534435011;
        Thu, 19 Feb 2026 12:53:55 -0800 (PST)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:50ba:724d:2a24:f591])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6ce01sm22026050c88.7.2026.02.19.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:53:54 -0800 (PST)
Date: Thu, 19 Feb 2026 12:53:52 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Tejun Heo <tj@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, dschatzberg@meta.com,
	peterz@infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <aZd4YCNTAHZNpTfh@mozart.vkv.me>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20260219164648.3014-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260219164648.3014-1-spasswolf@web.de>

On Thursday 02/19 at 17:46 +0100, Bert Karwatzki wrote:
> Since linux v6.19 I noticed that rebooting my MSI Alpha 15 Laptop
> would hang for about ~90s before rebooting. I bisected this (from
> v6.18 to v6.19) and got this as the first bad commit:
> 9311e6c29b34 ("cgroup: Fix sleeping from invalid context warning on PREEMPT_RT")
> 
> Reverting this commit fixes the reboot delay but introduces these error (which
> also seem to make the system crash sometimes):
> [    T0] BUG: scheduling while atomic: swapper/0/0/0x00000002
> 
> Compiling the kernel without PREEMPT_RT also fixes the issue.

Hi Bert,

I'm not seeing this behavior, there must be more to it than just this.

Could you share your kconfig? The dmesg with initcall_debug will be more
verbose during shutdown too, that may also help.

Thanks,
Calvin

> I've test these commits from "git log --oneline v6.19 kernel/cgroup"
> 
> This commit shows the reboot delay:
> 9311e6c29b34 cgroup: Fix sleeping from invalid context warning on PREEMPT_RT
> These commits show no reboot delay, but "scheduling while atomic" warnings
> and instability:
> be04e96ba911 cgroup/cpuset: Globally track isolated_cpus update
> b1034a690129 cgroup/cpuset: Ensure domain isolated CPUs stay in root or isolated partition
> 6cfeddbf4ade cgroup/cpuset: Move up prstate_housekeeping_conflict() helper
> 103b08709e8a cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping
> 55939cf28a48 cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to update_isolation_cpumasks()
> b66c7af4d86d cgroup: use credential guards in cgroup_attach_permissions()
> d245698d727a cgroup: Defer task cgroup unlink until after the task is done switching out
> This commit shows neither the reboot delay nor the "scheduling while atomic" problem:
> 260fbcb92bbe cgroup: Move dying_tasks cleanup from cgroup_task_release() to cgroup_task_free()
> 
> Bert Karwatzki
