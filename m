Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725657;
	b=AoKu3vKHTdk9ZmpXebb8kVyCp+7nIy0qgPLjADWocEQYcE2zQdUq9fLIt9egJBz1cpSe
	 c0U/yNTHpbC8tycSUTKzLkEQkWbZh1FLNJ5Zh+hvowI+SXpna6x8kGSaQEfzChJWkejjx
	 BdVnBoNGmCV91mm5Tw/2YP150cYv13MVzBjV++Gpq5VGpEAAGzZ5m/X0Gj9x+wo9ODN78
	 VlruzV7z1fqYoe2uY5kYoC1zHha1Rk2Wl6adJUBLM/pbFNuWeC+BivzBK927XeirpyBho
	 n0mfYjp0lnV6q50fMtDgFePGDMHiszwad2R3vWQR5X1QYZspXubpY/RAlTaek33+v6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=vhLI3luhSnY5QjC9WSQKZtTBj+4qzkm0fNGEEgLeI6U=;
	b=aeh3maT3HzUjZMwSHdlnZW/Ob4Se2FDWGESPxxDfNTIlYnQdHglWpYGtAy/ZfxGnqSoc
	 RukBbYwjEnF4eKZJOnlbf9N32EJ+4RGsgVNW9sq55XICvs1dbgxHEDlYCbU4XAs6GO9TV
	 TcPSaJLMey6MI17bQAp3nWumVBgiAcyIc69pfOVnu9xrDYt1/bpV9m6hJ5CKkWF2mfgKm
	 YQzAOYh7C+IFWnB/ynMeYweDXmTGdL33gZdSW4tcc86PRxpqjKuGcTAPHIjo+uwd5BnU7
	 7rT2JRhoJiN8kybhGfyoOS8QQgyzo0xUnF2VRkykzOfkfoE6lk4m/Dnm4r6BgOCIMMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UYXBM/rj";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C60606A323
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 20:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C60606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UYXBM/rj
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f07a960666so51154235ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 12:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795725657; x=1796330457; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vhLI3luhSnY5QjC9WSQKZtTBj+4qzkm0fNGEEgLeI6U=;
        b=UYXBM/rj36SXQ/dyyvrkRAzUKfoQH0RKRjkpjKWEEAxiIVlJuUfkoMFflA4lhReI+U
         Bzy/WCgMYZ7w8aJJZJLGpG+wUIf+rl1Y7/cG4pKMvdI1hlL3LXhp4rTAczEcBao0bhUt
         pIqAZwN1YeQNfMDbdpmLaFhkEdrDNr2Z/N6tuN6eL76GiLENBtscSs2x22pIbf3D+WD5
         tKq8d4CjIhliYoUzAZo3W7Vmw1OMbrlejCy4fCuqNlh21N/hzb1jWctnQlI3M2Fbo/tT
         RpVL9C4zf8xlQxaIjJ/sFK7Msrd3IDMWbMPDm+mKtuHeVPBkNUqGSw+Hdh8Q/C/yOhmd
         VTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795725657; x=1796330457;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhLI3luhSnY5QjC9WSQKZtTBj+4qzkm0fNGEEgLeI6U=;
        b=Hy/lD57pC4svDVdzgs9stGTzLvuAFgXK1QKxkgb7HAsDz+qGYNR9rOV1cs9GeeEdH1
         z7gDwS5++1v4Sp56UZQ4TmptTVvqVMcH9tlSEi0R5oHpVxHNcF3TTP3k/Zw0IWCPFYuJ
         To0Vt1zyPR0YCnTzbQrxTaw4w6ef8OVeONN0/s6192ZnEb2GA01w0505kvfqCW+OrL/C
         yNv3160p1WcitswI8W7ZZypAFuuPm+FD2huYk9wU0cZb+1p0T+mkeyOE/bjvc8izjyJj
         ZVMorCj8kjVW+CI0KAY6SdfZjpogo63qtvGZVQHhaJjdAScgC1ovBTyJBu+pjHiQ9ghY
         j78w==
X-Forwarded-Encrypted: i=1; AL+hErGGn+5ULSChcfi4P9agsQs5WNE3PL5gTJws0p5G1sJxCRGHI1PKEcbdk3NA076oTf05rIAplFfxyTvB/oi4Kw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/qv9ImbhIckmqipx6CIdJlLiPDIjkiOfYaMbc1ZurXs4br23LA
	nv/dnPUffwZTORPvQX6PhDwXIkw+K3qQcJ/451a+W9Fkf4t9GvClxOCB
X-Gm-Gg: AZFdTZc0L6UR/nlxZtyq+jNE67C2iUcrQ+XhW5EhJTXii6JtWqybXfNQhlxpcn88Psg
	rR/UapHRVO4krnuqypr5M+kuD5fslYZ5Wd0a8H2PpaWZiBVy+4r2gbSAfV8Wit/pTrkYGxIlkwo
	dxEyxz5sDy+naoVaThyLCceMoxOUrqxxN/+9M6NijI0snBdaIMisw1k5LlCee0bS3kyMzfqi5iV
	qWCguYbSOW45LPfXGEqBK1vwpfMtjticaMY5HtrhwHtaEOxyashxHYsOR01g8SOwdWpD/TtxDvq
	ZLh59JLhB44BpTSa9LAr4FC1pCjbY5GyXC43I+qkUgCJwlrAFKz2JeNINwTEOrmrvNxGxez/gUP
	bWYwRtzliuuqRSfWTTYlp2/Orp366mE0GyI0fx6En5r1Sqkebz3mlCzzeO9lNq8thVbskYyqAxv
	ftDzFwNO8fRWkBi10IADnpiofajDKrhTPu/d6Y8TQwHShzzKcuencX10k7/Z00cH3y8FYyq/9WK
	9qsNgQPbKLXeZa3SlT1C80D49GB3S7W3+2Q4B1StqV/bfULJ7qTbnQZdEuc45xh38LpA5EauXzb
	7dJ2bFJ2wb4tGfAi1L0N6hwHOP26SL692bfIOHm4y1eKPLFyULjV9kRpqUt1oXqvjwU8DXnzXDQ
	efwpV6ECCeeXUihCGb18kQD438dBulURj7Iw=
X-Received: by 2002:a17:902:f603:b0:2e9:8505:5471 with SMTP id d9443c01a7336-2f03ef44affmr240191085ad.7.1795725656537;
        Thu, 26 Nov 2026 12:40:56 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1a74sm110470815ad.12.2026.11.26.12.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:40:56 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:40:55 +0000
Message-Id: <DN5FM9P3X2P0.2IFD5DFBRELP1@gmail.com>
Cc: "Harry Yoo" <harry@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <daniel@iogearbox.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-rt-devel@lists.linux.dev>, "Vlastimil Babka" <vbabka@kernel.org>,
 "Hao Li" <hao.li@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>
In-Reply-To: <aecebb39-47c9-4b0f-a076-ac0ddc7724d9@kernel.org>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net> <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com> <20261126094403.GA49833@noisy.programming.kicks-ass.net> <aecebb39-47c9-4b0f-a076-ac0ddc7724d9@kernel.org>
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

On Thu, Nov 26, 2026 at 01:46 AM David Hildenbrand (Arm) <david@kernel.org> wrote:
> This is all just way too complicated and shaky, sorry to say it.

Which part?
I don't see any new concepts of failure modes vs existing code.
