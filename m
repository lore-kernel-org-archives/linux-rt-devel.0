Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589090;
	b=UEjiXscewR9gFH2QCfWCMRVUB60CHQth5K68oLf6JNfPz/eA6+4998nLer+aWh31YnGh
	 GbbN9xNms5TjXLrXutyZINOrSqOVIbn0oLinPnnkb4WV8ipKxCRot/J5cinypu8wp+4EJ
	 qgR2pbaI4P1cMZmWg81dD8B+l0E7rP6t5rP70xo+TU/sj5aiCXwqRbom6mxqT2ydZQ7JH
	 yp7U925q56SCjxBYXhNpyR54b7ziUO7E6Tv47/YHUsXSFhfpwwHJd5OvA7HtR8esFgfU0
	 qshF93httLROPlCFkQT4ym3qPMogfAIhsu4HNQfDxIs1Adwbvuwv4qbr13V3Vf/EXsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=gSlKv0ToGAeQ53lsfFOtI0+sE635JWib0pSuSvkBPtk=;
	b=bFEPLPTwTJyQmfAbRpuI5cfiBlSM5mSdgUEgQThwe7RknFoymYpQ6yLUzhcqD9O9kmcZ
	 2WJA4vPurg3kyIRCcfGV7Z4ri8Ft8f7jxVuWf/vH4KUmeDV45D0z4GqsA6aV6sot00nbU
	 T/7ahjN4x5f36MozWpSZ1+V3KRosToNgjHmmjmq+NyWbmNx9y4uWSWHRuakzV13koNiTE
	 9hqJ/0HZpxqIYM4dnaZat3ypFOsu4I/NbYJf1XPBLtJRZxUs1ZdHeMRkSZwIxHRlzcFd1
	 cBpbyWgJE0zEPC5L8EVoaz81aMDZlkNwo0b/HXvMONk4kjZhn2XoATAzgMVvzB93ugQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Hn8ui8sV;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B00606A31A
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 13:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21B00606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Hn8ui8sV
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e503815adso68181185a.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792589089; x=1793193889; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gSlKv0ToGAeQ53lsfFOtI0+sE635JWib0pSuSvkBPtk=;
        b=Hn8ui8sVgqaDjUldaFJu39e9lcnhdVsu27I0Fcy1T5qY4wWaW+JFugZDVHjfrPSEmg
         GSR1bitcJfFY2eZAxfrfRXi710OKYo5O+TmW1W47sEQ/2UZmBtQM3Zn9YyJs4fOSMcK7
         GSP6/csshi+FI3X1hbTtoCLUYFBqD91BpM1VEjLeV3UZkaG7Q/6rvyNnkan4SWHtmu+0
         qcneP9q45g4CHj4CBdUob+KIlll+/7hLkg8tl98b3CLoVP48vWDeRYKQPPlJLHTDc4O9
         rE96f6efhVlqDbVu4F08Bfi3v2t/Vy618GrjGpO48HD/RTa8evltSYIaXjU/WOsgzcBN
         7m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792589089; x=1793193889;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gSlKv0ToGAeQ53lsfFOtI0+sE635JWib0pSuSvkBPtk=;
        b=PBA6t/6ZXbt3bwxzo5+R28bznTiD3DLK89uoP9odSImHm6zi71dzLWbXmpN9sDwb/g
         I3Y+62O25f/rsGd2dkLfHj5D0HgnaNngN7brCCgLA7J8GcjqT4obMNZsGipSWC5JyzKN
         /qInSKRVTspbHb92+gHpyKjaPS9e04DozpaRmUb0uvWySY0dgmNXDMiihfAvJ/HVCjjp
         4kQ7326JOqt543G1hTdXbXjjMqli1/hvDCcAmw+FinDf3okUb9Ff9h6fjfTWXvrIBKHc
         ipZ1V+wT1XHSHD/p1Zv/8ydrRL1e2GJUGsiK4Cmj6WLwB7Iuwvz8kjS0RBlayWypNfNx
         KReA==
X-Forwarded-Encrypted: i=1; AKwUvBy5HIMgIv37YRxdvpbiN80uNXWKQjlS+KzVOMiFVbQDutYcenMwzhMn5D/atxGjwxxxJ109oQCc81HRQ8cVsA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLItVIFff8tiMts70SI+9grXh4t4ur+APC2ddDZptmXE/mhDSF+
	fce206plWXZcSb8dhi8oGhH4MuYJ3zgiGh8zdEaKPs/tj759ouboLBTXTwcE4hZq2t4=
X-Gm-Gg: AYBFou2tp62Y2fTN572jqIzHVDEulgFLe4RDaWUbuV1a+JZU+G6aWLSDDczL20vunNQ
	MZyAPs6aPJMexG8QKEGgumsqXWoy3D2g21aXBBcS6DeHp7NlTeGsmUkwcNpf/LQaZhWmm8BgdRk
	BCrFim81+oHGqaA9cX7W2XXUDtOvuf0+aRk/DJ5S1OTTvZyFkUE+S+YF5UhxWWUZCUCfMJZjhEI
	km6/F0++yAsGgAKz8oi2aKBSIQkGWK9Ujx0QBrxgVt7aK5OM3ztXQuWPvdtmzB3kWM5Tyc4gKRZ
	MNFV3daAIA5Fj33diP+Dfww1uMft0ChUrYMcS9rSs+NtQGop7lRhWK1loDivel7EfxvK1oeMjhh
	/bdXivAIiic202M0qZIHgPLHjTOQGsWee5ps9/JtSfIJqi2Dmkt5q7eisvdQjLb3fg1OM+Yyx3Q
	6UqXl8zV9aIw6qgAnQ1U+dYTXcASGgsIo7J9oOM45GnHjTV1Vm4TOzDeEWoMPYYh8iN0L5Jvnde
	5S5YkKCXBHcPQFRzYGexJ7MMgoQxipUnu3B6X+zbzZxNzkwTDLJTqQkMIboeLEpxy7+Jx8MT9bO
	xKCk1KflXcjmCItCoFIQD/Dtb70l47GTnkKXBdB3Z//K3Y/a
X-Received: by 2002:a05:620a:4496:b0:93e:5861:34df with SMTP id af79cd13be357-93f57feafa5mr395621285a.47.1792589088891;
        Wed, 21 Oct 2026 06:24:48 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e221fcsm250054885a.40.2026.10.21.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:24:48 -0700 (PDT)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/8] mm: fix allocator races with memory hotplug
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, 
 akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com, 
 shakeel.butt@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, muchun.song@linux.dev, osalvador@suse.de, 
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, 
 ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
 mgorman@techsingularity.net, anshuman.khandual@arm.com, 
 Bessel.Wang@huawei.com, jiang.liu@huawei.com
In-Reply-To: <63521469-3829-4895-a7d9-a0f7806c58a1@kernel.org>
References: <20261021023940.1940971-1-gourry@gourry.net>
 <63521469-3829-4895-a7d9-a0f7806c58a1@kernel.org>
Date: Wed, 21 Oct 2026 09:24:45 -0400
Message-Id: <179258908579.2324641.832287495252342628.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-21 10:24 +0200, David Hildenbrand (Arm) wrote:
> On 10/21/26 04:39, Gregory Price (Meta) wrote:
> 
> Usual reminder to slow down a bit :)
> 
> We have
> 
> 	Documentation/process/submitting-patches.rst
> 
> Saying
> 
> 	"Wait for a minimum of one week before resubmitting or pinging reviewers
> 	 - possibly longer during busy times like merge windows.
> 
> A lot of this here was broken forever, so there is no need to rush.
> 
> (thanks for the fixes ;) )
>

felt prudent to get the adjustment Vlastimil recommended out to avoid
time wasted on v1 since it was somewhat significant - but ack.

~_~ found a 9th instance of the same bug. Will send next week.

~Gregory

-- 
Gregory Price (Meta) <gourry@gourry.net>
