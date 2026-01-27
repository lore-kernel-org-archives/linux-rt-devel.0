Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C135B125
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524146; cv=none; b=f6ikgcFmKXYb98OPFg8IyLIECrc0qECgXb8CqbzLG1xgV42Me2MDHgw7W2UbmS00v5/H8t9lP3x5dOtgXyDU/mE2Ad9GU23yN3EVaFxizR3Ds5pP/Bcca/VvAfuspb/XPSOemvnNIYGtd96blmTrESwOAYqY9guh7uMn2wANqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524146; c=relaxed/simple;
	bh=qSm0alfl5BI5F+EUqVMRslKei9mFJ679Do3KWYLs6MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyHlDytcvv+OzBO9ce9i0oxIZHuoCaoq7/Lg31r7y4yzssmdhAHui61WH7jUJWyQbIdNMoZ+q9ddZdC2+Alj1mWpR1xvzNd/NNgtaCs5h3FK6gTBR7ihntsE8CATFyLGWxaLr2twKT+zVrO/eR0LiU8euOtrbmAdAq+Ga/5hZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABS2+hKN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABS2+hKN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d256c2e6so5519155f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769524143; x=1770128943; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RzsSYm6I8uueV/iFR6SlAY5cx6+4mIHkGt73AMjJd/E=;
        b=ABS2+hKN7XKk3knKqXapfM5Gc04sJujy/bb/HY06z8IoNX6tRCkJ3qnLjS72SQgIgm
         FSTrRNNpQiqeDKSvtfyDJGl4o+XeF41Qjw9ZDpVDXFSxN/JgIf7KDcmNh2QN0X30s3o4
         8G2Yua/y0/cb6dhnSQn7e/KkhKbhPllvoOVBwzjGa7PQgPBaVQDenRBBX8PyMdZe3OO8
         KQo0Twgen08v/fF78acbmtjAjDg2JLIgRtNaO+t55qwNRrcQHiZX2SYnuAMh+XC1Made
         Xmn7ydgU5pNK0LvjiK9zMyIllRP7cFZeKV/pcskMrPdlpGTeZ0Dru8PM8uK0n9WZ+4XI
         5c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524143; x=1770128943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzsSYm6I8uueV/iFR6SlAY5cx6+4mIHkGt73AMjJd/E=;
        b=Drt4NNMrzNFJJ4JQScLAHSUQ+ngZ0Py7W/LAFvSlbwKiXLCx+gCAwuvqO2lP3P7Yg/
         nNZn7BBET4cIl5gnQuP40pjBK+IoN5gcKQxgQD6KRzB1uAiHpmX/u/QAaeBhCWd0YiYF
         Yo1ybxQxuCTxZU/Il1EF19HfpUePIx23TQJ+aii7vSWk+Nn2JmjmpqizM1KMm5fa4L93
         +GH8DFkvGAzxrqBOmQG3qQpU9Zfz4bh1RSqZxO+LvMPNB7fg0uWR1xxPKcuNZhYEZKC1
         rqzfmhUmawq/gW75LFHUpX1HHRvjxDh4Z/HSq2f3pM0yQWqOw7+2+1hAc24PN2FAqT3B
         Wzrw==
X-Forwarded-Encrypted: i=1; AJvYcCUhIU11KF7zj8s1u/Q5VVgPH1LbxKEVEgWjMz7el0fmUskZKc+orMUld+Cu3hYls2BQM2/1zJhuWtdCkPRvrw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg7eBsGe+IO11gCWTUZW1rRYbXUViPgyhR94rCn/p4fQWKlHpV
	TAi9pVEXcKEWF23IrgUkhZ6KTurdIz1phnEAToVSLz379FzZK3/JJo3N
X-Gm-Gg: AZuq6aJLxDKkB4jgojbYzfyQhMjeTG90pxV41Pop+CKc2PqTosd9Tmwjle4nOfQE0ct
	XwSO9nDmnzRTT11a16wdHyB+/v4OykAhFyguMe91tnKNoRBQ43xKuWTedfr2TBVVU9ZIwroVMt3
	Lc6S1UPD/pvXUjRi7g3ErSy3OAMEUPj7agEsmVNrqTNGJfmS3Ii5R8T7kg/T2jOpIiabh5El9z8
	UCG9N4lOLV3NO9ew3ePMVKldAKhcULIR+1mrdvux+hc4GIsU9Ev/+clzWnL29pq9w9giuNEWYJ2
	QrGQbrbyGeukuQ647fAEVYPhm9UgzLTObcsXgGrb7YZ7RGVgJ5+zmTLwAYVC3J6HrCmi7oFkeah
	ncyV8/EUwwhChVcwcWzJbzZXTkpELcDer4wGGPWUn2FYzUrQ/Kmfdot7FZ/Xt8uUJtU8Yp04YJ5
	pqXpYJgAtfhuv3BcDzDNRcp/EhYo4wqYIRk7o40hPuVM5Gs+lV2o5x4TFsxBM=
X-Received: by 2002:a05:6000:2082:b0:435:a9c9:159 with SMTP id ffacd0b85a97d-435dd05aba3mr2633501f8f.18.1769524142351;
        Tue, 27 Jan 2026 06:29:02 -0800 (PST)
Received: from f (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02ba3sm37600235f8f.2.2026.01.27.06.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 06:29:01 -0800 (PST)
Date: Tue, 27 Jan 2026 15:28:53 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 18/22] slab: refill sheaves from all nodes
Message-ID: <cburjqy3r73ojiaathpxwayvq7up263m3lvrikicrkkybdj2iz@vefohvamiqr4>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-18-041323d506f7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123-sheaves-for-all-v4-18-041323d506f7@suse.cz>

On Fri, Jan 23, 2026 at 07:52:56AM +0100, Vlastimil Babka wrote:
> __refill_objects() currently only attempts to get partial slabs from the
> local node and then allocates new slab(s). Expand it to trying also
> other nodes while observing the remote node defrag ratio, similarly to
> get_any_partial().
> 
> This will prevent allocating new slabs on a node while other nodes have
> many free slabs. It does mean sheaves will contain non-local objects in
> that case. Allocations that care about specific node will still be
> served appropriately, but might get a slowpath allocation.

While I can agree pulling memory from other nodes is necessary in some
cases, I believe the patch as proposed is way too agressive and the
commit message does not justify it.

Interestingly there were already reports concerning this, for example:
https://lore.kernel.org/oe-lkp/202601132136.77efd6d7-lkp@intel.com/T/#u

quoting:
* [vbabka:b4/sheaves-for-all-rebased] [slab]  aa8fdb9e25: will-it-scale.per_process_ops 46.5% regression

The system at hand has merely 2 nodes and it already got:

         %stddev     %change         %stddev
             \          |                \  
      7274 ± 13%     -27.0%       5310 ± 16%  perf-c2c.DRAM.local
      1458 ± 14%    +272.3%       5431 ± 10%  perf-c2c.DRAM.remote
     77502 ±  9%     -58.6%      32066 ± 11%  perf-c2c.HITM.local
    150.83 ± 12%   +2150.3%       3394 ± 12%  perf-c2c.HITM.remote
     77653 ±  9%     -54.3%      35460 ± 10%  perf-c2c.HITM.total

As in a significant increase in traffic.

Things have to be way worse on systems with 4 and more nodes.

This is not a microbenchmark-specific problem either -- any cache miss
on memory allocated like that induces interconnect traffic. That's a
real slowdown in real workloads.

Admittedly I don't know what the policy is at the moment, it may be
things already suck.

A basic test for sanity is this: suppose you have a process whose all
threads are bound to one node. absent memory shortage in the local
node and allocations which somehow explicitly request a different node,
is it going to get local memory from kmalloc et al?

To my understanding with the patch at hand the answer is no.

Then not only this particular process is penalized for its lifetime, but
everything else is penalized on top -- even ignoring straight up penalty
for interconnect traffic, there is only so much it can handle to begin
with.

Readily usable slabs in other nodes should be of no significance as long
as there are enough resources locally.

If you are looking to reduce total memory usage, I would instead check
how things work out for resuing the same backing pages for differently
sizes objects (I mean is it even implemented?) and would investigate if
additional kmalloc slab sizes would help -- there are power-of-2 jumps
all the way to 8k. Chances are decent sizes like 384 and 768 bytes would
in fact drop real memory requirement.

iow, I think this patch should be dropped at least for the time being
