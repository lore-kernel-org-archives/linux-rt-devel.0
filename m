Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655278;
	b=MnDLCUG+bnw8EDa0QuQ/3vwy72NDX3D3wjnJe279aoXOt+Cb3g+dQzNgmYoRSdjmwbpY
	 GZy9OD8988pccHFoYye00gzPc00tc5hPwjDAxCg5yqpVB7n0brIeutg9SbUCvuHq2GebZ
	 ckdfy/wkBS6rrLnNX3Kw0qzkt5eRaZiPFqXx2kfdwssn1pwBtn7veEbPRLGxp6FLU2Eyf
	 abdZFhbzM46USLtCcrr204+IIv58XsHgDu8o6tUBAlKd+J7gbFytQOfsCr8j+rFUTd52U
	 JVqFnGBLeCyuymxuMHTAUSK+Vh6x0lBW7iZ7ggAs/6AqYqtSArzDwpaObYv0/OQsQ8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=0e+Ouu+6oLoZy2ujzXapWcEGF96bjKcfmd5hC33j504=;
	b=F6r+hbazOkrabviDJ3Uyl5zjl//Sl/lis6CUyRq3VmXH+MNiJneI7joOmhKytfLZU1pm
	 FdxOQZvznG4NRJEJHvYHpAhfiNgHXVlDaAyjIW34ws8jwLrfjMNOlYikr72B4+vauTzUG
	 F1+5Aon0WPJNAXBGsrvBjzPK0ljDBn4o8z4WZeOyvEHrAlh3LgotiuoyCu+U9KNgs+qCb
	 xit8zioW+uNTQgjlWVyVYc9sVxF2G8MNCTbCctBKgGWVt7M6X+W6qhXAdM+cnaokHV4Ga
	 WctAXHSB8kpK3jbgK8kzkfKgg8ACRdqQ8FkEWl7+nyx5Rr9QWJte6mMCN9oqx3/GjVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VUyXIptH;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FF606A321
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 01:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB5FF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VUyXIptH
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so3926804b3a.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 17:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655277; x=1796260077; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0e+Ouu+6oLoZy2ujzXapWcEGF96bjKcfmd5hC33j504=;
        b=VUyXIptHxCiWZt/QcNZP1LHz92lieXYR9zTwqEoII+oFwGK17vv+6oWPzSQ9XKc58K
         WklxvlvhucSkFql8SRBuLl4TFjWXZquccj8Wfh9kD4+o6gzNImWg35BWlppj3ePrSuUp
         ZqjI27HK133PCdV7iNZr71VoHwNUzkb6Q0i7xQK+H9ax9jzpFzBVB7z0eXql0cPQzJgz
         M+dP6O5gzhT72llvcuRRDaDpQdl4GXv5SnQceEbHzodJJ+B0WnJsvOmS6uwluUh+rza9
         l/GUjknBbQpOkBABxUtt8LBZ2oEpDIXUE5uu+fHovo7G8balXFdW0RttGCqj1K8QJnlX
         r6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655277; x=1796260077;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0e+Ouu+6oLoZy2ujzXapWcEGF96bjKcfmd5hC33j504=;
        b=kengqL3d+O4zv2X7da9Xs0UpzQZMcuL/jWk1/NZqXNm01QHQCnQ7kQAwUa8YkrKYt6
         zfVw0beIn5FJySt9eYzB4xMgR4xewobUPDUrP5JZdpMFO1MQI+R+/QNHnegbZBAk9rAp
         ZN80RVF/iyEFzWfENmG9At6rQZSkdMzpiLzIhD0jIPAiOLhf/eExzWALBczpianGNVBh
         WsMEw4JHgYkNrjfBFgGVp3fbUfJk3RTbD88V/Qgmc1Jkcsv7MYiSbxvXqND8/2OWHQGA
         byP2KdQSrdx042o+tG68DKAatLlNinVSYz1s+ATOXQMHZ+/wRM5olYy2lay3c8FheOkl
         9knA==
X-Forwarded-Encrypted: i=1; AL+hErFpnTgSPF9a5NWwtBF0tGgtpIAF9UyEmChRQW98Mm3ugzgS0/XzJJC+6Gj1T6+SjLuyMEO+/2o6X6SlcdmVaQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Vq0q6xtKOSkGtnM9R0eDaqamSKQtsU+j2tq400zF9QAEfbp6w
	sVmWInXM21+PqaT+okzDYX00dZ/L0n86/4cTZ7ovQXTvyINmZ7LqY6pf
X-Gm-Gg: AZFdTZebqy1HbM4YlgWniq+77Rnp1FFOl/M0DW6j0lFdgJy+ODtw9a9S5NOf4tGB+lX
	rpbwKsx0R4c21RLgzBl7fs/WMYjMqqztv8OYrjB8O6KmWMFrqzBcxe/f18niL79f2smRG7LXREw
	laCgQXPI8uMXSUL+D+pP18KQtOLrQSRCW0gQwfbMhmjqGWR7JvjMxGVpvhnz1Kppjqm0UD3zBxq
	SetqIkGewmfMdfudltcyvs2eJWwPhJNk1yDH+ykcRvXL5Dz/X/gPtFtq0PCNj/mio/EPnqsvjDL
	XZeLqcssJl8cHongBAG+sPhAgRSaZ2s4mn8SZNWpMiB/j7wP4+4QB4rHMhsQasjbhwnO/K1SF4D
	kcVT+wUt59X8saQexjR9IQK7Xgy+OPrEyZLOZF0wa1TUzjM37eIOjrMDFD00ovC9i7Wk+i2zyDB
	xcy8M45eXMBRKISQmU9eRj/53gTymxMHHkzL9WaBla4hYii+22h2u6L+5wWgk+W1vsz9yq5t4Sr
	9hAr72z4vIoMEM4E5+kyncp+VNSusFHsX+GyT2LI5hXF/3w8RTuoJDMTR5vy9Sn8YJibYpyClBi
	BFcpPjZ2sIp7r9ehJ60BydqA8UnRa2EGwFD+smfGTyPz/R4KIY3UwDj48ny9pIRm+IQRpGRXa5X
	oTLhGFK50UXLahPQBkv/jV3pbe2T+Sb2qr0A=
X-Received: by 2002:a05:6a00:c08a:20b0:8c7:f59c:e82e with SMTP id d2e1a72fcca58-8c7f59cee72mr10451362b3a.36.1795655276950;
        Wed, 25 Nov 2026 17:07:56 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4c43bsm9633902b3a.26.2026.11.25.17.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:07:56 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 01:07:55 +0000
Message-Id: <DN4QO5PPVN0Z.1CO2JSCYRH04R@gmail.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-rt-devel@lists.linux.dev>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>, "David Hildenbrand"
 <david@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Waiman Long"
 <longman@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Peter Zijlstra" <peterz@infradead.org>, "Harry Yoo" <harry@kernel.org>
In-Reply-To: <20261125160409.GF2668804@noisy.programming.kicks-ass.net>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net> <awbvek-HS3OJYJGF@thinkstation> <20261125160409.GF2668804@noisy.programming.kicks-ass.net>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 08:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Nov 25, 2026 at 02:30:52PM +0000, Harry Yoo wrote:

>> One remaining accident we're aware is that we cannot attempt a
>> spin_trylock or local_trylock under pi_lock (even on !RT).

No. It's RT only. Already answered in the other email.
Nothing wrong with !RT.

