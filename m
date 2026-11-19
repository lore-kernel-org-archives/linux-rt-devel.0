Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083642;
	b=ckKJPACSLTFbW+rvNFeEnAfj7zGd+5Cuan2Y+7M4foj+S81778OiXc2YsR3SJ5IM6f9x
	 WuWDyXQtKWdMlzufhKzZssEL1r6zW89706nlYmPuawxgcPVU645DuUYv1FJh4bdLWwrai
	 Z1xpFY4wUuRiMQpMK6/aQfvRJSkDft1nfqTuLc18ddDQee7bAa4azxp7CHsJAg0sFkQ4O
	 2ebGLolQpFxGJJVwR69Au7nabZxCpkq6idZF5U7sZxlje4JkQ12aOBxMvzi++o0S2Q1qM
	 YdejpnjEgkaBOIvvh4+sSfOdotZiWbsLngGBIsnqZstemBQB5gJGgUYZh0SJA5Jks5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083642;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=BhMldp/vd/3xPeYieMpRCN6PVD+GGJcYfaPHMFtkt6g=;
	b=w+mUdByB/cRHBtzd8bb1EfCaqWfdqdd701RuV7b6BaQtsz96MoxyJsDhj6egBWp9t1M/
	 mx0uIuwYtjH3ykDDEkS6BRTV4fR1AfYE04iyzXf808VT352ftjdME2AawfVq7zg/o4xWE
	 HIU9msyH1aqRMPf9EUFVcTgThSsjAiYZwwiQc4X7rJAxGpk/fZDTnxo0EuGQwbpUCajau
	 84K6GnsMIy3Uz9ja0KKKYLYHd9r1zE27fGU2CBviTMOJrTkD7fZIpowO5gsWISQhMymb/
	 VWDELBTI2CVc18VrlavDpUugqVHCfQXW5vmAFHgu3qj1NQCchzN2tQh/D7kOt5jmaCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZJjKcIAP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A8606A324
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 10:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 574A8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZJjKcIAP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795083641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhMldp/vd/3xPeYieMpRCN6PVD+GGJcYfaPHMFtkt6g=;
	b=ZJjKcIAPDD/yQ65jf0mFAYZwb/LjWSOdF+4hzLUZOfGETFmP9M/KxxYhW4HaIFTAJF8AUL
	pt89I0sqUCzwk7qK1Yyfv5pa0qnb93Q25zciKKx+5yAH9Qxyr8Ih/6AzEIPmyH5lWA2lNu
	p9bx62r2EKmtVA9gPE+yOOlw7fVfr30=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-GOsBRkUzOY2_RgtHYShSEQ-1; Thu, 19 Nov 2026 05:20:39 -0500
X-MC-Unique: GOsBRkUzOY2_RgtHYShSEQ-1
X-Mimecast-MFC-AGG-ID: GOsBRkUzOY2_RgtHYShSEQ_1795083639
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-490c1867460so1233482f8f.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 02:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795083639; x=1795688439;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhMldp/vd/3xPeYieMpRCN6PVD+GGJcYfaPHMFtkt6g=;
        b=Byd4pFtKtnKxeye85ZxwutW9VZVS2M3js1qpALOculnXHiCR9HcbmWmpQqn48GDiAg
         LAlokL5ZgwCYiYaUsIh9VZv+r9NeMDjbZ0pjms76FgUrm9LZxJvHdQTWpv4Kf1bik23v
         PzuTaOYKVkpJzGEyauh9QI54E7Z6CRzzu8Wl85JN0G7OSoJxFNkFobSfyqpPer6GOaDU
         eVA/vbhWdNI3jp1eA2Y5er5J9VdLvHAL/6k2RwCA5jE0vB2zc69c6eH09dv1q2WXpU/K
         gPoWpPWIPii5WlCt6NVb88pIeQnMbr/GMy9JuPQ7BFG8+ZtgLtljHDeRI0qaWb1xFvmR
         wDgw==
X-Forwarded-Encrypted: i=1; AL+hErGc5aem3rx5md0NolU2gyfQqc6sVAo+d95PcI1CvGyFDsy67Lglw4mUz8LR7z4wuI5SWcBkgTaIZkoMc7SRgg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+nB14OoaKGgCbpKhf/Tqr2v2dpzb0kQTLX+nM6t3wA20h0vbL9
	O2GLx3xqgB+f+GE+BmBs8OaVqtumX8r+SAlCEtquJ3N3fx/M+1Q+Ko4znNzvHLn6sL1TAHm+xwz
	N6Y6OcjF4V9qFcMukhVrv/cfB7PORM6mV9iEKjdAufjbbUM/UxWcMDRIaHfIv0b3EADrm
X-Gm-Gg: AYBFou2nyr4PwhBeJhSceVJl9dsGz28s2SKhMxyKqB5tc3MEuReemLNsLoegaa5cIUC
	Cz/lmwVNXjYp+mw56mZHg3NqKPLZielnMYE8hzl8AJfoqbzczLrf+ViBZse32SwT533BMWFXVr0
	dE+hahXsz57VJz6VycHDL4cyCjWzRj8cg7hFK2lUvBmQz5B2qZJmDluDLmzoYI47zE8tFWA3vZD
	07n06bOEGDWbsJvtg0hBa8QE1YzyTC7dfaA22aPQDofYtH0UaHmh4dMYi+pvp9HkgGmsv+xlJs0
	HDVzbiOBDAbIM7EyejO8zki6PrTVvBBJP/ji7oO/59cvlGvbB/M1LSv+hMeuXeV65bk3aKvso4D
	NF7KH2mt2Of2g4c7UKgfRQZsnvPW7wnoZutRgGCL3d/UCHsJIYHDD9m53H26b2enPz8NVrIdsY6
	s2OSw=
X-Received: by 2002:a05:600c:4e45:b0:4bb:6814:738c with SMTP id 5b1f17b1804b1-4bb7da267bamr95705395e9.22.1795083638695;
        Thu, 19 Nov 2026 02:20:38 -0800 (PST)
X-Received: by 2002:a05:600c:4e45:b0:4bb:6814:738c with SMTP id 5b1f17b1804b1-4bb7da267bamr95704865e9.22.1795083638277;
        Thu, 19 Nov 2026 02:20:38 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm37226425e9.13.2026.11.19.02.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:20:37 -0800 (PST)
Date: Thu, 19 Nov 2026 11:20:34 +0100
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
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 00/16] sched/deadline: first bandwidth accounting
 fixes and selftests
Message-ID: <av7NchMg0wnyzjcd@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1795037078.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1795037078.git.mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0H-Wh0ioYTC9buxzH0QWCPxDLpw3DZgYpn8Ex7_BksI_1795083639
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 18/11/26 16:24, Mathieu Desnoyers wrote:
> Hi Ingo, Juri,
> 
> This series fixes 13 bugs of SCHED_DEADLINE. Then it shows the deadline
> bandwidth of each runqueue in sched_debug, and adds two selftests. The
> fixes come first, so that stable can take patches 1 to 13.

Thanks for splitting this out. I ran v2 in 8-CPU guests with lockdep and
proxy exec on. deadline_switch_test passes 5/5 (sysrq cases included),
and deadline_bw_test passes 45/46 (move_cancelled skips without
RT_GROUP_SCHED). There were no splats. Reverting patch 10 brings back
asleep_round_trip, stopped_switched_out and overrun_caught, as claimed.
cgroup's test_cpuset_prs.sh also passes, as on rc2.

I also covered two of the "not tested" items:

- cgroup v1 cpusets (two exclusive cpusets, root load balancing off):
  admission, affinity, refused moves and hotplug all behave as on v2.
  On both v1 and v2, moving a task A -> B -> A leaves its bandwidth
  in B, so A is under-counted once the task dies. The leak is on rc2
  too and the full v7 fixes it, so it is not a regression.

- sched_ext: the in-tree sched_ext selftests pass on v2, total_bw
  included (dsp_local_on needs IKCONFIG_PROC for its __kconfig extern).
  With scx_simple loaded, deadline_switch_test passes. The server cases
  of deadline_bw_test fail, because they configure fair_server, which is
  detached while ext is enabled. Pointed at ext_server, server_params,
  server_rebuilds, server_states and server_reclaim pass. hotplug_server
  still fails there, as scx_simple gets ejected when the CPU goes
  offline (I haven't dug further). Could the test pick the server that
  is active?

...

> Patch 10 clears the parameters of a task that leaves the class asleep.
> On v7.4-rc2, such a task kept them. That hid a bug of the rtmutex chain
> walk

Please move this into the changelog of patch 10 itself, as the cover
won't end up in git. IIUC, the owner then sits in the patch 8 bail-out
with a deadline of "now" until it unlocks. Other deadline tasks keep
their bandwidth, but lose latency, and RT/fair tasks on that CPU get
possibly starved.

Doesn't your separate "Fix an overflow of the 0-lag time with long
periods" also fits here, right before patch 10, which adds a caller of
that computation?

Patch 5: yes, keep my Reviewed-by on the version with the cpu_active()
check.

Thanks!
Juri

