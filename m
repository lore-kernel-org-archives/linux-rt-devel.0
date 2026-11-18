Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996739;
	b=pwHokktOZ7yfyvsjmixCVHKpJc5ZrrTckzr8S2qc2bZ2ewUm1VMnLbSm7UZDRr6cfab6
	 Ic+87pVSSaO7+VcT9LN3OvJTcIbnUDfaWim6viQK6dzU1VlKTZ9cuO0qN6qkWGE1RE3JV
	 bki0q/C5J/wNPH7cmobhqZibdZfLPxRdFm0aogAcOnvpiZ5PwiTi7wLun+5K3+mMWZK/4
	 9BNdZS1IhaWxaUGFp3V1QLiuKUE13uBuadAVnzGBbMXZaCJ5lMNoUt9H1/byZ3stenXF9
	 IfBXYhaLdI9i8PfArPfgRSj4ri6SNL7MH/Z2JNbkusa759rNspEwgzq8j9ypFid3T4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996739;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wOvZstlG0NBbv/dzQM6xwLtQ/0sPGNaMMnmH8lqZPgo=;
	b=EpInguwWjVPlpMbCMUeWX46+owsMgQgTaOPlE6Wu//GTs1Tx0pjGvTFls4WlTI5TDLe8
	 1iaFxK5AM+fz3dwirlJ2PXVmUF3nIRRV3h9i6DIPjuGaq0Im9AHVB2/FGwIzhqQzVzUAg
	 vSDJSAxSOHtlpxLFSMuc6mHQ6OpeiGoggf/rwEPZYfvFFnVXjUsZDzZuQlffvO1mKlZt/
	 RyZtO8h4nYvJG9nyl8Pnl5GZ8DJpE2qGZEhU2ZQtZGRzjKgu6lAuKNa61Nrq7asfX3Orr
	 0kAJ/rq7EupIx/4gJUBD1S8psSGe8gNy0EB+mS1/9puBVPimaiSHjgnViXNmUS8YJUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G7ViuwWa;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44C606A884
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 10:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F44C606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G7ViuwWa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794996739; x=1826532739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FF5B0ph4nYkrwjb1C6748DuKV0yiQO0WYfTjj9OFyQw=;
  b=G7ViuwWajQav9rOyEN7Dz3bgI7Q1V4bXUGSxQed/cSOx6vzau3ugq1md
   qd7W6s7PBQjHJHLWH9NZdoNuJh7FePxxnOQMn564PKfVLLxl2jeYU5V8e
   0/sAsfeGYZZ47cetnihH40P+TiwpMJ0Q+Jy1bpRQPh1SQPbW9tABCZV6J
   3iWol6PLgYYD9gz0d/9nSFSNLyFlZTEvFGGX+ciJ4IOGF4K6XDo/HyUCt
   vHZmsv5f+6zjXYUEvYB7ZzQvJhGbZXHATjAVb4sahnJ8pjoSFXvmkPYQt
   zUVWoL7tQcZFYVWazzBBdpoQA1Ifv0KbeBznaJZdqztkmqY9+W6ybInjN
   g==;
X-CSE-ConnectionGUID: Wpxcy7K2Q0S8+Bw87IXlNQ==
X-CSE-MsgGUID: TitLnBNrSw2+n7ivlz6O8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3682651"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3682651"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 02:12:18 -0800
X-CSE-ConnectionGUID: D/5dg/T/T7egAVJfdbIJDg==
X-CSE-MsgGUID: 7vyP09MJSo22wc5qpMf9JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10052164"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa007.jf.intel.com with ESMTP; 18 Nov 2026 02:12:15 -0800
From: Jiebin Sun <jiebin.sun@intel.com>
To: akpm@linux-foundation.org,
	bigeasy@linutronix.de
Cc: dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	tim.c.chen@linux.intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	jiebin.sun@intel.com
Subject: Re: [PATCH] lib/percpu_counter: allow concurrent sums with an rwlock
Date: Wed, 18 Nov 2026 18:16:46 +0800
Message-ID: <20261118101646.3192636-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261115191636.f18859e4dd5f58b9a33e7814@linux-foundation.org>
References: <20261115191636.f18859e4dd5f58b9a33e7814@linux-foundation.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew and Sebastian,

Thanks for the comments and the RT review.

I'll replace the macros with static inline helpers, add the RT comment,
and clarify the practical callers, including percpu_counter_sum_positive(),
in v2.

Interrupt readers can bypass a WAITING writer and delay it if they keep
overlapping. I'm considering the impact this could have on counter
updates. If this needs addressing, we might take the write lock in
__percpu_counter_sum() when called from interrupt context, while keeping
the read lock for ordinary sums.

I also tested buffered writes with fio.

Fio (64 jobs, 3 iterations, 60s each):

  +------+------------+-----------------+---------+
  | Test | Throughput | CPU utilization | Cycles  |
  +------+------------+-----------------+---------+
  | Fio  |     +6.91% |         -40.41% | -40.80% |
  +------+------------+-----------------+---------+

Test configuration: ext4, 32 GiB cgroup memory limit.

Commands:

  sysctl -w vm.dirty_bytes=67108864 \
             vm.dirty_background_bytes=33554432

  fio --name=buffered-write --directory="$TEST_DIR" \
      --ioengine=sync --rw=write --bs=64k --size=256m --numjobs=64 \
      --direct=0 --fallocate=none --time_based=1 --runtime=60 \
      --cpus_allowed=0-31,86-117 --cpus_allowed_policy=split \
      --group_reporting --output-format=json

Thanks,
Jiebin
