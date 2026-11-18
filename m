Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001215;
	b=Jc1OzDbN+udlxWytkxsiuxTW8S0t0yotEQAroGKV/euTGqZGz5w6++Jm+GIYPs8uoq2T
	 pZe78EVFQzv7LJki5f0Y5lZIpHq+RxhhvtvArFwht1baQxtEn1mKDKEk0J45GbPc7c/5p
	 yFMHCN/y4PeJowMK2Yf8WTSa/C5pvX/tQuNKiTjOxhysRsxBZ6u758R3eF0dtzU9OElV6
	 FfeVbtiIflBdcz5dWMXmjryLBh4Qkh7tOoFWgnTEYuShhMd0POstY6/exnUXtM/viMU45
	 uWnLj8bNeSGVoLcBGptQPOWLN7sKjcdU6th377CfT1fbnLUV8xNxru4wu7X0EygUCuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001215;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=brXugAcDbaCylrm2Wl7ARVAM15xweZmcyeF8T+2xKUM=;
	b=sFqO/VzD2qAJRtobGd8KqOPPK+aYqtucN7Twx4sk598fovhygs8uxssoJqyke7EhRE9S
	 xzShcm8Aiha5ibI58cN5F/tn9J7gP8eF8GEgR30qLMaL9GDgg5oxj6wVWm+R8DVS7Ew8A
	 NXqVvBEMJKRlC1XNq1nJ7WqX/k+85W0b3T7WQG1kKip01WOUXRNDB1Aiz31e33EDY+KKk
	 GWVgcsY4KW2IuTRssFFVYu+6ruSiDm8aWq7ur9gmlE7McaZnLkFYCyrkpiWnhGxVWnFXU
	 Ydt7HB853QZHAHSXanozlcj9ZTZinrZ73TBPoxBWSmDq9Vr9j4+rZDJ7IayCIKrMn3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxC0T23G;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776B60A2602
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 11:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E776B60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxC0T23G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795001210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=brXugAcDbaCylrm2Wl7ARVAM15xweZmcyeF8T+2xKUM=;
	b=cxC0T23GX+hVrYrCiT3BImcD06onQItqKjsxCI8uzmIoqUEr9NAFRJrOCFCGC0WlZwEdtm
	vJWNOLSu+4abvAJxDutpswDIp16i6T/ImBmx3Fzauw/z+AqYMcqpnerlnqXq9EyATg/ojV
	mH3+pyBer2JcZBh8hAm3t/aP/cBRG2s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-9HqbuSoIP2WOVGMx83RYFA-1; Wed, 18 Nov 2026 06:26:46 -0500
X-MC-Unique: 9HqbuSoIP2WOVGMx83RYFA-1
X-Mimecast-MFC-AGG-ID: 9HqbuSoIP2WOVGMx83RYFA_1795001206
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48df02b91f9so1116260f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 03:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001206; x=1795606006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brXugAcDbaCylrm2Wl7ARVAM15xweZmcyeF8T+2xKUM=;
        b=MRUhdJ+ktFZOYGlzUu2Eh4W76O2VKpbSfFKOExR5ghPukPMuqfxeM0Odir5l2Cxi1W
         RSyvHzEi8B4/BjiLT5hAMs5oFubLCuTNLsDPUZvCTHENEvgvcR40ihBmhXrCemsdVofj
         4MtPTVrzXab/QwnWyOfhTQjeNdT4fPjOXMb4DpgdgtO0cW4Hd5O0HaNWXC+Aj54kWhcu
         X+5iT4bkuwLMJJzEDuItrHlkqRsoQy+AKGhPAfe2aVK6wu+ZVTVJR3h/sbytzDFw/QFy
         LCToUiWg+E+3Tf9h1aDwaR66b8GYqHhbLys0n4o9QYlRT8KuPCfJNHBjcVBXNDpKpkct
         iEmg==
X-Forwarded-Encrypted: i=1; AL+hErFYeP3rusg41dJQ37/Liw1PULhj1cy+ftrFhZGZ6jsNYUPzYPe6YhbA1Cbo3033e+0PfJ+kxbSq+XXh2bTG3w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9oqGeiLZ7uydodWpCp7A9ltonOs4oCz4ZxpRycO4OAQjkNLVu9
	WShNyfcT9JO4yL4AmPzV0s5O+Ap6tUPpksgHZiYKoVnoMq1jay4qJMJ/GCS08kQims0bF0019Ow
	difSkpTccVQvISDAmozOoodEa8gVCs1k+1SVaGhjs0VoVvGnINESdvwzmZBnYj1Uf0M1+
X-Gm-Gg: AYBFou2R5nRqIr559YZ4KYe6f2lfPcRjqn5SEwmZSVqQDw7x5W5dmeoRE2H5fZopiHR
	4mBlgwFkFMOwY/3Ubdyl4eMfrbKDK6Vk+FSjT0VSkKn4fv6zvqKVi/vMBZHAZ36D+ABIAYH8Wi1
	7Gl1n9ctpG80lqqD00Sp1X/vKI9y1oZenl49yiKD1x5fctXbmpbdQfZ1/DdYh2d8dzP88wW3FZK
	8001ennUXAoF44YtSK2QfYNQZCg74FpIoY4TMijiu17xFy93ilQVVqzD+uEFwNzNxECsIpt09IB
	231+Zm01652iD+ekLwHGfofeaEK4/FnaKBSBVKZFkw64vquPRuhYCt01dpcJMO6Ai4V+LLbqa37
	cLuWZKAJBde1Fr4ozgD1vFlCTaeNM15/g1vV+iHlXimYiQ/4tPmubMEpoX1zRMieYpiWciEuOy7
	uwfRo=
X-Received: by 2002:a05:600c:1d8e:b0:4b9:f90b:1c4d with SMTP id 5b1f17b1804b1-4bb783aec42mr139593285e9.5.1795001205701;
        Wed, 18 Nov 2026 03:26:45 -0800 (PST)
X-Received: by 2002:a05:600c:1d8e:b0:4b9:f90b:1c4d with SMTP id 5b1f17b1804b1-4bb783aec42mr139592495e9.5.1795001205361;
        Wed, 18 Nov 2026 03:26:45 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560b2a1sm4049093f8f.32.2026.11.18.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:26:44 -0800 (PST)
Date: Wed, 18 Nov 2026 12:26:41 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 05/40] sched/deadline: Refuse dl_server debugfs writes
 while the rq is offline
Message-ID: <av2LcczdGk37WJLm@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <2bee6a143319301f082855a15274f0563e99b8a5.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <2bee6a143319301f082855a15274f0563e99b8a5.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H6kNzxByhVRhgB2xBCrgdwAl0jdUsOtTHikL-e2uk3k_1795001206
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 17/11/26 09:10, Mathieu Desnoyers wrote:
> Commit 4043f5498416 ("sched/deadline: Reject debugfs dl_server writes
> for offline CPUs") refuses a write to a dl_server's runtime or period
> on an offline CPU. Its message says that such a write has no meaningful
> semantics.
> 
> It tests cpu_online(). But during hotplug the CPU is still online while
> it sits in the default root domain. This lasts from the rebuild in
> sched_cpu_deactivate() to the offline, and from the online to
> sched_cpu_activate(). That root domain does not count the server's
> bandwidth. A write in the window still goes through admission. With
> admission control off, it changes total_bw there. On v7.4-rc2, a write
> of the current value divides by zero in that window. The previous patch
> removes the division, not the write.
> 
> Fix this by testing rq->online instead. It is set under the runqueue
> lock when the CPU joins a root domain that counts it, after
> cpu_active() is set.
> 
> A write now fails with EBUSY while the CPU goes offline or comes
> online, as a write on an offline CPU already does. Writes at any other
> time are unchanged.
> 
> Applied without the previous patch, this patch alone also stops the
> oops. The reproducer survives 20 rounds with no warning, in 3 VMs of 3.
> 
> Fixes: d741f297bcea ("sched/fair: Fair server interface")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

